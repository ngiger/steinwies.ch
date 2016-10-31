#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/simple_app'
require 'rack'
require 'rack/show_exceptions'
require 'webrick'
DRb.start_service('druby://localhost:0')
name = File.basename(File.dirname(__FILE__))
logname = File.expand_path(File.join(File.dirname(__FILE__), "log/access.log"))
FileUtils.makedirs(File.dirname(logname))
use Rack::Session::Cookie, secret: "MY_SECRET"
puts "Using Rack::Session::Cookie"
use Rack::Session::Pool
puts "Using Rack::Session::Pool"
#  myapp = MyRackApp.new
myapp = Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::PassThrough.new( Steinwies::App.new )))
sessioned = Rack::Session::Pool.new(myapp,
  :domain => 'foo.com',
  :expire_after => 2592000
)

Rack::Handler::WEBrick.run sessioned, {:Port => 8888}
