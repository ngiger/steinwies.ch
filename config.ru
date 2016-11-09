#\ -w -p 8006
# 8006 is the port used to serve
lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'src').untaint)
$LOAD_PATH << lib_dir
require 'util/config' # load config from etc/config.yml
require 'steinwies'
require 'util/app'
require 'rack'
require 'rack/static'
require 'rack/show_exceptions'
require 'rack'
require 'webrick'

SBSM.logger= ChronoLogger.new(Steinwies.config.log_pattern)
use Rack::CommonLogger, SBSM.logger
use(Rack::Static, urls: ["/doc/"])
use Rack::ContentLength
SBSM.info "Starting Rack::Server Steinwies::AppWebrick.new with log_pattern #{Steinwies.config.log_pattern}"
app = Rack::ShowExceptions.new(Rack::Lint.new(Steinwies::AppWebrick.new()))
run app
