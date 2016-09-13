#!/usr/bin/env ruby
# DissertationState -- Steinwies -- 04.12.2002 -- benfay@ywesee.com 

require 'state/global_predefine'
require 'view/dissertation'

module Steinwies
	class DissertationState < GlobalState
		DIRECT_EVENT = :dissertation
		VIEW = Dissertation
	end
end
