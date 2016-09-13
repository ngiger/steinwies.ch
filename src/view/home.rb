# Home -- steinwies -- 19.11.2002 -- benfay@ywesee.com

require 'htmlgrid/component'
require 'htmlgrid/urllink'
require 'util/lookandfeel'
require 'view/template'

module Steinwies
  class Index < HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => 'praxisschild',
    }
    CSS_MAP = {
      [0, 0] => 'title',
    }
    COMPONENT_CSS_MAP = {
      [0, 7] => 'mailto',
    }
    SYMBOL_MAP = {
      :schildpers_main => HtmlGrid::Link,
    }

    def init
      1.upto(6) do |num|
        y = 3 * (num - 1) + 1
        css_map.store([0,y], 'subtitle')
        components.store([0,y], "schildpers#{num}")
        components.store([0,y + 1], "schildtitel#{num}")
        components.store([0,y + 2, 0], "schildtel#{num}")
        components.store([0,y + 2, 1], :"schildmail#{num}")
        symbol_map.store(:"schildmail#{num}", HtmlGrid::MailLink)
      end
      super
    end
  end

  class Home < Template
    CONTENT = Index
  end
end
