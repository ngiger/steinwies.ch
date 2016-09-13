#!/usr/bin/env ruby
# LageplanView -- Steinwies -- 04.12.2002 -- benfay@ywesee.com 

require 'htmlgrid/component'
require 'htmlgrid/text'
require 'htmlgrid/image'
require 'view/template'
require 'custom/lookandfeel'

module Steinwies
	class Plan < HtmlGrid::Composite
		COMPONENTS = {
      [0,0]		=>	"plantitle",
      [1,1]		=>	"planbeschreibung1",
      [0,1]		=>	:planimage,
		}
    CSS_MAP = {
      [0,0] => 'subtitle',
    }
		SYMBOL_MAP = {
			:planimage			=>	HtmlGrid::Image,
		}
	end
	class Lageplan < Template
		CONTENT = Plan 
	end
end
