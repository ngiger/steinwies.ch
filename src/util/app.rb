# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'steinwies'
require 'util/config'
require 'util/session'
require 'util/trans_handler.steinwies'
require 'util/config'

module Steinwies
  class App < SBSM::DRbServer
    SESSION = Session
    def call(env)
      sbsm = SBSM::Request.new(Steinwies.config.server_uri, Steinwies::TransHandler.instance, env)
      response = sbsm.process
      response.finish
    end
  end
end
