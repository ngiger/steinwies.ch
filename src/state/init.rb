#!/usr/bin/env ruby
# InitState -- Steinwies -- 03.12.2002 -- hwyss@ywesee.com 

require 'state/global_predefine'
require 'view/home'

module Steinwies
	class InitState < GlobalState
		DIRECT_EVENT = :home
		VIEW = Home
	end
end
