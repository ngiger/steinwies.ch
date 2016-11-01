#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/simple_sbsm'
require 'sbsm/app'
require 'rack'
require 'rack/show_exceptions'
require 'webrick'
DRb.start_service('druby://localhost:0')
uri = URI('http://'+Steinwies::Session::SERVER_NAME)
SBSM.info "Calling Rack::Server.start"
Rack::Server.start(
  :app => Rack::ShowExceptions.new(Rack::Lint.new(SBSM::App.new(Steinwies::SimpleSBSM.new ))),
  :Port => uri.port
)