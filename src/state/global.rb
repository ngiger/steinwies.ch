# GlobalState -- Steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/state'
require 'state/home'
require 'state/person'
require 'state/kontakt'
require 'state/schwerpunkte'
require 'state/lageplan'
require 'state/dissertation'

module Steinwies
  class GlobalState < SBSM::State
    GLOBAL_MAP = {
      :home         => HomeState,
      :person       => PersonState,
      :schwerpunkte => SchwerpunkteState,
      :dissertation => DissertationState,
      :lageplan     => LageplanState,
      :kontakt      => KontaktState,
    }
    DIRECT_EVENT = nil
    VIEW         = Home
  end
end
