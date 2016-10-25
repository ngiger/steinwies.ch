#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/app'
require 'rack'
require 'rack/show_exceptions'
require 'webrick'
DRb.start_service('druby://localhost:0')
name = File.basename(File.dirname(__FILE__))
logname = File.expand_path(File.join(File.dirname(__FILE__), "log/access.log"))
FileUtils.makedirs(File.dirname(logname))
app = Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::App.new))
# app = Rack::ShowExceptions.new(Steinwies::App.new)
sessioned = Rack::Session::Pool.new(app,
  :domain => 'foo.com',
  :expire_after => 2592000
)
Rack::Server.start( :app => sessioned,
                    :Port => 8004,
                  )
Rack::Handler::WEBrick.run sessioned, {:Port => 8004} if false
