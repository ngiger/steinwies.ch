#!/usr/bin/env ruby
# index.rbx -- steinwies -- 19.11.2002 -- benfay@ywesee.com

require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), '../src').untaint)
puts lib_dir
$LOAD_PATH << lib_dir
require 'steinwies'
require 'util/config'
require 'util/app'
require 'pp'
require 'rack'

# pp Steinwies.config
DRb.start_service('druby://localhost:0')
# use Rack::ShowExceptions
# Rack::Server.start :app => Steinwies::App.new, :Port => 9191
require 'rack/show_exceptions'
Rack::Server.start(
  :app => Rack::ShowExceptions.new(Rack::Lint.new(Rack::SteinwiesApp.new)), :Port => 9191
 ##   resource '/public/*', :headers => :any, :methods => :get
)
