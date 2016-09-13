#!/usr/bin/env ruby
# LinksState -- Steinwies -- 04.12.2002 -- benfay@ywesee.com 

require 'state/global_predefine'
require 'view/links'

module Steinwies
	class LinksState < GlobalState
		DIRECT_EVENT = :links
		VIEW = Links
	end
end
