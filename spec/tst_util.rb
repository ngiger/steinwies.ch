# some helper constant for tests
require 'steinwies'
require 'util/config'

# 11080 must be in sync with first line in spec/config.ru
TEST_SRV_URI = URI.parse(ENV['TEST_SRV_URL'] || 'http://127.0.0.1:11080')
TEST_APP_URI = URI.parse(ENV['TEST_APP_URL'] || 'druby://127.0.0.1:11081')

SteinwiesUrl = TEST_SRV_URI.to_s
Steinwies.config.server_uri    = TEST_APP_URI.to_s
