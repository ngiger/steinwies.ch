# Person -- Steinwies -- 04.10.2003 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/person'

module Steinwies
  class PersonState < GlobalState
    DIRECT_EVENT = :person
    VIEW         = Person
  end
end
