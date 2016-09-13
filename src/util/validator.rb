#!/usr/bin/env ruby
# Validator -- Steinwies -- 03.12.2002 -- benfay@ywesee.com 

require 'sbsm/validator'

module Steinwies
	class Validator < SBSM::Validator
		EVENTS = [
			:back,
			:home,
			:person,
			:schwerpunkte,
			:dissertation,
			:lageplan,
			:kontakt,
			:links,
			:confirm,
			:sent,
			:sendmail,
		]
		STRINGS = [
			:anrede,
			:name,
			:vorname,
			:firma,
			:adresse,
			:ort,
			:telefon,
			:bestell_diss,
			:bestell_pedi,
			:text,
		]
	end
end
