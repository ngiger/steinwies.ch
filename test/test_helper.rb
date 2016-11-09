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

# debugging
DEBUG    = (ENV['DEBUG'] == 'true' || false)
DEBUGGER = ENV['DEBUGGER'] \
  if ENV.has_key?('DEBUGGER') && !ENV['DEBUGGER'].empty?
TEST_CLIENT_TIMEOUT = 5 # seconds

TEST_SRV_URI = URI.parse(ENV['TEST_SRV_URL'] || 'http://127.0.0.1:11080')
TEST_APP_URI = URI.parse(ENV['TEST_APP_URL'] || 'druby://127.0.0.1:11081')

require 'watir-webdriver/wait'
module WaitUntil
  def wait_until(&block)
    raise ArgumentError unless block_given?
    Watir::Wait.until {
      block.call.wait_until_present
    }
    block.call
  end
end

module Steinwies::TestCase
  include WaitUntil
end

Watir.driver = :webdriver
Watir.load_driver
Watir.default_timeout = TEST_CLIENT_TIMEOUT

Steinwies.config.document_root = root_dir.join('doc').to_s
Steinwies.config.environment   = 'test'

require 'util/app'
require 'rack/test'

begin
  require 'pry'
rescue LoadError
end

class SteinwiesTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    SBSM.info msg = "Starting #{Steinwies.config.server_uri}"
    DRb.start_service(Steinwies.config.server_uri, Steinwies::AppWebrick.new)
    sleep(0.1)
  end
  def teardown
    DRb.stop_service
  end
  def app
    Steinwies::AppWebrick.new
  end
end
