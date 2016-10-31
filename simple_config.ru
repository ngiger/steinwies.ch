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
use Rack::Session::Pool
myapp = Rack::ShowExceptions.new(Rack::Lint.new(PassThrough.new(Simple.new )))
sessioned = Rack::Session::Pool.new(myapp,
  :domain => 'foo.com',
  :expire_after => 2592000
)
Rack::Handler::WEBrick.run sessioned, {:Port => 8888}
