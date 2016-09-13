# DissertationView -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'htmlgrid/text'
require 'htmlgrid/image'
require 'util/lookandfeel'
require 'view/template'

module Steinwies
  class DissDl <  HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => 'download',
      [0, 1] => :flyer,
      [0, 3] => :deprivation,
      [0, 5] => :diss_pdf,
      [0, 7] => :diss2_pdf,
    }
    CSS_MAP = {
      [0, 0] => 'subtitle',
    }
    SYMBOL_MAP = {
      :flyer       => HtmlGrid::Link,
      :diss_pdf    => HtmlGrid::Link,
      :diss2_pdf   => HtmlGrid::Link,
      :deprivation => HtmlGrid::Link,
    }
  end

  class Diss < HtmlGrid::Composite
    COMPONENTS =  {
      [0, 0] => 'disstitel',
      [0, 2] => 'disstext',
      [0, 1] => :titelseite,
      [1, 1] => :meierhofer,
      [2, 1] => DissDl,
    }
    SYMBOL_MAP = {
      :titelseite => HtmlGrid::Image,
      :meierhofer => HtmlGrid::Image,
    }
    COLSPAN_MAP = {
      [0, 2] => 3
    }
    CSS_MAP = {
      [0, 0] => 'subtitle',
    }
  end

  class Dissertation < Template
    CONTENT = Diss
  end
end
