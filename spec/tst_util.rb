# some helper constant for tests
require 'steinwies'
require 'util/config'
require 'sbsm/logger'
require 'util/kontaktmail'

# 11080 must be in sync with first line in spec/config.ru
TEST_SRV_URI = URI.parse(ENV['TEST_SRV_URL'] || 'http://localhost:11080')
TEST_APP_URI = URI.parse(ENV['TEST_APP_URL'] || 'druby://localhost:11081')

SteinwiesUrl = TEST_SRV_URI.to_s
Steinwies.config.server_uri    = TEST_APP_URI.to_s
Steinwies.config.server_name   = TEST_SRV_URI.hostname
Steinwies.config.server_port   = TEST_SRV_URI.port
Mail.defaults { delivery_method :test }
TEST_CHRONO_LOGGER = File.join(File.dirname(__FILE__), '..','/spec_%Y%m%d.log')
Steinwies.config.log_pattern = TEST_CHRONO_LOGGER
