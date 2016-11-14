# Steinwies::Session -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/session'
require 'util/validator'
require 'util/lookandfeel'
require 'state/states'

module Steinwies
  class Session < SBSM::Session
    SERVER_NAME      = Steinwies.config.server_port ? Steinwies.config.server_name + ":#{Steinwies.config.server_port}" : Steinwies.config.server_name
    DEFAULT_LANGUAGE = 'de'
    DEFAULT_STATE    = HomeState
    DEFAULT_ZONE     = 'page'
    LOOKANDFEEL      = Lookandfeel

    def initialize(key, app, validator=Validator.new)
      super(key, app, validator)
    end

    def flavor
      # steinwies does not use flavor
      nil
    end

    def zone
      # steinwies does not use `actual` zone
      # see also trans_handler.steinwies.rb
      DEFAULT_ZONE
    end
  end
end
