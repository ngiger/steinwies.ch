# index.rbx -- steinwies -- 19.11.2002 -- benfay@ywesee.com

require 'sbsm/request'
require 'steinwies'
require 'util/config'

DRb.start_service('druby://localhost:0')
begin
  SBSM::Request.new(Steinwies.config.server_uri).process
rescue Exception => e
	$stderr << 'STEINWIES-Client-Error: ' << e.message << "\n"
	$stderr << e.class << "\n"
	$stderr << e.backtrace.join("\n") << "\n"
end
