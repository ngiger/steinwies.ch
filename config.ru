#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/app'
require 'rack'
require 'rack/show_exceptions'
DRb.start_service('druby://localhost:0')
Rack::Server.start(
  :app => Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::App.new)),
  :Port => 9292,
)
