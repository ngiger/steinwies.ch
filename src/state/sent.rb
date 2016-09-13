#!/usr/bin/env ruby
# SentState -- steinwies -- 08.01.2003 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/sent'

module Steinwies
	class SentState < GlobalState
		VIEW = Sent
	end
end


