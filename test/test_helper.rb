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

# Dir[root_dir.join('test/support/**/*.rb')].each { |f| require f }

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

class SteinwiesTest < Minitest::Test
  include Rack::Test::Methods
  @drb_server = nil
  def app
    @app = Steinwies::App.new
  end
  def setup
    @drb = Thread.new do
      begin
        DRb.stop_service
        @drb_server = DRb.start_service(Steinwies.config.server_uri, app)
        DRb.thread.join
      rescue Exception => e
        $stdout.puts e.class
        $stdout.puts e.message
        $stdout.puts e.backtrace
        raise
      end
    end
    # Wait for service to be ready, or the tests will fail with DRb-errors
    until @drb_server && @drb_server.alive? do  sleep 0.005 end
    @drb.abort_on_exception = false
  end
  def teardown
    # @drb.exit
    DRb.stop_service
    @drb_server = nil
  end
end
