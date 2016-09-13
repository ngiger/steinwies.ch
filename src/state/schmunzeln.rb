# SchmunzelnState -- Steinwies -- 18.12.2002 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/schmunzeln'

module Steinwies
  class SchmunzelnState < GlobalState
    DIRECT_EVENT = :schmunzeln
    VIEW         = Schmunzeln
  end
end
