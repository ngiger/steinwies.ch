require 'pathname'

root_dir = Pathname.new(__FILE__).parent.parent.expand_path

src = root_dir.join('src').to_s
$: << src unless $:.include?(src)

test = root_dir.join('test').to_s
$: << test unless $:.include?(test)

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'util/config'
# Overriding ports and log destination
$: << root_dir.join('spec').to_s
require 'tst_util'
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
