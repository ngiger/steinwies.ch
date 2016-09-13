#!/usr/bin/env ruby
# SteinwiesApp -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'util/steinwiesconfig'
require 'util/session'

module Steinwies
	class SteinwiesApp < SBSM::DRbServer
		SESSION = Session
	end
end
