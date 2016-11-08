require 'pathname'

root_dir = Pathname.new(__FILE__).parent.parent.expand_path

src = root_dir.join('src').to_s
$: << src unless $:.include?(src)

test = root_dir.join('test').to_s
$: << test unless $:.include?(test)

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'watir'
require 'rclconf'
require 'steinwies'
require 'util/config'
require 'watir/wait_until'
require 'util/app'
require 'drb'
require 'sbsm/logger'
require 'rack/test'

# debugging
DEBUG    = (ENV['DEBUG'] == 'true' || false)
DEBUGGER = ENV['DEBUGGER'] \
  if ENV.has_key?('DEBUGGER') && !ENV['DEBUGGER'].empty?
TEST_CLIENT_TIMEOUT = 5 # seconds

TEST_SRV_URI = URI.parse(ENV['TEST_SRV_URL'] || 'http://127.0.0.1:11080')
TEST_APP_URI = URI.parse(ENV['TEST_APP_URL'] || 'druby://127.0.0.1:11081')

Dir[root_dir.join('test/support/**/*.rb')].each { |f| require f }

module Steinwies::TestCase
  include WaitUntil
end

Watir.driver = :webdriver
Watir.load_driver
Watir.default_timeout = TEST_CLIENT_TIMEOUT

Steinwies.config.document_root = root_dir.join('doc').to_s
Steinwies.config.environment   = 'test'
Steinwies.config.server_uri    = TEST_SRV_URI.host
puts TEST_SRV_URI

def start_steinwies
  SBSM.info msg = "Starting #{Steinwies.config.server_uri}"
  $browser = Watir::Browser.new(:chrome)
  binding.pry
  puts Steinwies.config.server_uri
  DRb.start_service('druby://localhost:0', Steinwies::AppWebrick.new)
  sleep(0.1)
end
def visit(path)
  $browser.goto path
end

def browser
  puts "Returning #{$browser}"
  $browser
end
at_exit do
  puts "at_exit"
  $browser.close
  DRb.stop_service
  puts "at_exit done"
end

start_steinwies
class SteinwiesTest < Minitest::Test
  include Rack::Test::Methods
  def app
    Steinwies::AppWebrick.new
  end
end
