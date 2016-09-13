# Person -- steinwies -- 19.11.2002 -- benfay@ywesee.com

require 'htmlgrid/component'
require 'htmlgrid/text'
require 'htmlgrid/image'
require 'util/lookandfeel'
require 'view/template'

module Steinwies
  class PersonRight < HtmlGrid::Composite
    COMPONENTS = {
      [0,  0] => 'person_title',
      [0,  1] => 'person_text',
      [0,  2] => 'werdegang_title',
      [0, 10] => 'erfahrung_title',
    }
    COLSPAN_MAP = {
      [0,  0] => 2,
      [0,  1] => 2,
      [0,  2] => 2,
      [0, 10] => 2,
    }
    CSS_MAP = {
      [0,  0] => 'subtitle',
      [0,  2] => 'subtitle',
      [0, 10] => 'subtitle',
    }

    def init
      offset = 2
      1.upto(7) { |num|
        components.store([0,num+offset], "werdegang_date#{num}")
        components.store([1,num+offset], "werdegang_text#{num}")
      }
      offset = 3
      8.upto(12) { |num|
        components.store([0,num+offset], "werdegang_date#{num}")
        components.store([1,num+offset], "werdegang_text#{num}")
      }
      super
    end
  end

  class PersonLeft < HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => :schildpers_main,
      [0, 1] => 'schildpers_main2',
      [0, 2] => 'schildpers_main3',
      [0, 3] => 'schildpers_main4',
      [0, 4] => :portrait,
    }
    CSS_MAP = {
      [0, 0] => 'mailto',
    }
    COMPONENT_CSS_MAP = {
      [0, 0] => 'mailto',
    }
    SYMBOL_MAP = {
      :portrait        =>  HtmlGrid::Image,
      :schildpers_main => HtmlGrid::Link,
    }
  end

  class PersonFrame < HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => PersonLeft,
      [1, 0] => PersonRight,
    }
  end

  class Person < Template
    CONTENT = PersonFrame
  end
end
