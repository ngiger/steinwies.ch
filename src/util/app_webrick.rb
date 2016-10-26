# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'sbsm/app'
require 'steinwies'
require 'util/config'
require 'util/session'
require 'util/trans_handler.steinwies'
require 'util/config'
require 'util/app'
require 'pry'

module Steinwies
  class AppWebrick < SBSM::App
    def initialize
      puts "Passing app Steinwies::App"
      super(app: ::Steinwies::App,
            validator: Steinwies::Validator.new,
            server_uri: Steinwies.config.server_uri,
            trans_handler: Steinwies::TransHandler.instance,
            session: Session,
            )
      self
    end
  end
end
