#!/usr/bin/env ruby
# Session -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/session'
require 'util/validator'
require 'custom/lookandfeel'
require 'state/states'

#require 'sbsm/version'
#warn SBSM::VERSION
#$stderr.puts SBSM::VERSION
$stderr.puts $LOAD_PATH

module Steinwies
	class Session < SBSM::Session
		DEFAULT_LANGUAGE = "de"
		DEFAULT_STATE = InitState
		LOOKANDFEEL = Lookandfeel
		SERVER_NAME = 'www.steinwies.ch'
		def initialize(key, app, validator=Validator.new)
			super
		end
	end
end
