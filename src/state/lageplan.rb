# LageplanState -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/lageplan'

module Steinwies
  class LageplanState < GlobalState
    DIRECT_EVENT = :lageplan
    VIEW         = Lageplan
  end
end
