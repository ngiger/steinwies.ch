#!/usr/bin/env ruby
# Schwerpunkte -- Steinwies -- 04.12.2002 -- benfay@ywesee.com 

require 'view/template'
require 'custom/lookandfeel'
require	'htmlgrid/text'

module Steinwies
	class Schwerpunktlist < HtmlGrid::Component
		ITEMS = [		
      "schwerpunkte_list1",
      "schwerpunkte_list2",
      "schwerpunkte_list3",
      "schwerpunkte_list4",
      "schwerpunkte_list5",
      "schwerpunkte_list6",
      "schwerpunkte_list7",
      "schwerpunkte_list8",
      "schwerpunkte_list9",
		]
		def items_html(context)
			ITEMS.collect { |item|
				context.li{@lookandfeel.lookup(item)}
			}.join
		end
		def to_html(context)
			context.ul{
				items_html(context)
			}
		end
	end
	class Schwerpunkt < HtmlGrid::Composite
		COMPONENTS = {
      [0,0]				=> "schwerpunkte_title1",
      [0,1]				=> Schwerpunktlist,
      [0,2]				=> "schwerpunkte_title2",
      [0,3]				=> "schwerpunkte_text2",
      [0,4]				=> "schwerpunkte_title3",
      [0,5]				=> "schwerpunkte_text3",
		}
    CSS_MAP = {
      [0,0] => 'subtitle',
      [0,2] => 'subtitle',
      [0,4] => 'subtitle',
    }
	end
	class Schwerpunkte	 < Template
		CONTENT = Schwerpunkt
	end
end
