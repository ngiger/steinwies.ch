#!/usr/bin/env ruby
# LinksView -- Steinwies -- 04.12.2002 -- benfay@ywesee.com 

require 'view/template'
require 'custom/lookandfeel'

module Steinwies
	class Link < HtmlGrid::Composite
		COMPONENTS = {
      [0,0]			=>	"link_title",
      [0,1]			=>	"link1",
      [0,2]			=>	"link2",
      [0,3]			=>	"link3",
		}
    CSS_MAP = {
      [0,0] => 'subtitle',
    }
  end
	class Links < Template
		CONTENT = Link
	end
end
