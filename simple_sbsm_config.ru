#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/simple_sbsm'
require 'rack'
require 'rack/show_exceptions'
require 'webrick'
DRb.start_service('druby://localhost:0')
name = File.basename(File.dirname(__FILE__))
logname = File.expand_path(File.join(File.dirname(__FILE__), "log/access.log"))
FileUtils.makedirs(File.dirname(logname))
uri = URI('http://'+Steinwies::Session::SERVER_NAME)

Rack::Server.start(
  :app => Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::PassThrough.new(Steinwies::SimpleSBSM.new ))),
  :Port => uri.port
)