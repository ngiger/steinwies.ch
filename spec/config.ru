#\ -w -p 11080
# 11080 must be in sync with TEST_SRV_URI from tst_util.rb
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), '../src').untaint)
$LOAD_PATH << lib_dir
$LOAD_PATH << File.dirname(lib_dir)
require 'util/config'
require 'spec/tst_util' # to override the DRB-port
require 'util/app'
use Rack::Reloader, 0
use Rack::ContentLength
use(Rack::Static, urls: ["/doc/"])
map '/doc' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['first_post', 'second_post', 'third_post']] }
end
app = Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::AppWebrick.new()))
run app
