# SchmunzelnView -- Steinwies -- 18.12.2002 -- benfay@ywesee.com

require 'htmlgrid/component'
require 'htmlgrid/text'
require 'htmlgrid/image'
require 'util/lookandfeel'
require 'view/template'

module Steinwies
  class Laugh < HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => 'favoritemail_title',
      [0, 1] => 'schmunzelntext',
    }
  end

  class Schmunzeln < Template
    CONTENT = Laugh
  end
end
