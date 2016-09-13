# Schwerpunkte -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/schwerpunkte'

module Steinwies
  class SchwerpunkteState < GlobalState
    DIRECT_EVENT = :schwerpunkte
    VIEW         = Schwerpunkte
  end
end
