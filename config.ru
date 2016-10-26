#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/app_webrick'
require 'rack'
require 'rack/show_exceptions'
require 'webrick'
# DRb.start_service('druby://localhost:0')
name = File.basename(File.dirname(__FILE__))
logname = File.expand_path(File.join(File.dirname(__FILE__), "log/access.log"))
FileUtils.makedirs(File.dirname(logname))
require 'rack/static'
# use Rack::Static, :urls => ["/doc", '/doc/resources/pdf', '/doc/resources', '/doc/resources/errors' ]

app = Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::AppWebrick.new()))
# app = Rack::ShowExceptions.new(Steinwies::App.new)
sessioned = Rack::Session::Pool.new(app,
  :domain => 'foo.com',
  :expire_after => 2592000
)
Rack::Server.start( :app => sessioned,
                    :Port => 8004,
                  ) if false
Rack::Handler::WEBrick.run sessioned, {:Port => 8004} if false

use(Rack::Static, urls: ["/doc/"])
# Rack::Handler::WEBrick.run(Rack::Builder.new, Port: 8006, app: sessioned,)
Rack::Handler::WEBrick.run sessioned, {:Port => 8004} if false
map '/doc' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['first_post', 'second_post', 'third_post']] }
end
use Rack::ContentLength
Rack::Server.start( :app => sessioned,
                    :Port => 8004,
                  )

