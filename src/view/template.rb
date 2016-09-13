#!/usr/bin/env ruby
# Template -- steinwies -- 27.11.2002 -- benfay@ywesee.com

require 'htmlgrid/template'
require 'view/navbar'

module Steinwies
	class Foot < HtmlGrid::Composite
	end
	class Template < HtmlGrid::Template
		COMPONENTS = {
			[0,0]		=>	Navbar,
			[0,1]		=>	:content,
		}
		CSS_CLASS = "template"
		HTTP_HEADERS = {
			'Content-Type' => 'text/html; charset=utf-8',	
		}
	end
end
