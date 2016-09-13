# Template -- steinwies -- 27.11.2002 -- benfay@ywesee.com

require 'htmlgrid/template'
require 'view/navbar'

module Steinwies
  class Foot < HtmlGrid::Composite
  end

  class Template < HtmlGrid::Template
    CSS_CLASS  = 'template'

    COMPONENTS = {
      [0, 0] => Navbar,
      [0, 1] => :content,
    }

    HTTP_HEADERS = {
      'Content-Type' => 'text/html;charset=UTF-8',
    }

    META_TAGS = [{
      'http-equiv' => 'robots',
      'content'    => 'follow, index',
    }]
  end
end
