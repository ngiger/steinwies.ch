# Sent -- steinwies -- 08.01.2003 -- benfay@ywesee.com

require 'htmlgrid/text'
require 'view/template'

module Steinwies
  class SentText < HtmlGrid::Composite
    COMPONENTS = {
      [0, 3] => 'senttext',
    }
  end

  class Sent < Template
    CONTENT = SentText
  end
end
