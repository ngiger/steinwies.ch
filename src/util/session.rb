# Steinwies::Session -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/session'
require 'util/validator'
require 'util/lookandfeel'
require 'state/states'

module Steinwies
  class Session < SBSM::Session
    SERVER_NAME      = Steinwies.config.server_name
    DEFAULT_LANGUAGE = 'de'
    DEFAULT_STATE    = InitState
    LOOKANDFEEL      = Lookandfeel

    def initialize(key, app, validator=Validator.new)
      super
    end

    def flavor
      # steinwies does not use flavor
      nil
    end

    def zone
      # steinwies does not use zone
      nil
    end
  end
end
