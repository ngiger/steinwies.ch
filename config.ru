#!/usr/bin/env ruby
require 'sbsm/request'
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/app_webrick'
require 'rack'
require 'rack/show_exceptions'
require 'webrick'
name = File.basename(File.dirname(__FILE__))
require 'rack/static'
use(Rack::Static, urls: ["/doc/"])
map '/doc' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['first_post', 'second_post', 'third_post']] }
end
use Rack::ContentLength
Rack::Server.start( :app => Rack::ShowExceptions.new(Rack::Lint.new(SBSM::App.new(Steinwies::AppWebrick.new()))),
                    :Port => 8004,
                  )

