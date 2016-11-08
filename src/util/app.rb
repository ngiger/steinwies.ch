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
    SESSION = Session
    attr_reader :trans_handler, :validator, :drb_uri
    def initialize(persistence_layer=nil)
      SBSM.info "Steinwies::AppWebrick.new"
      @validator = Validator.new
      @trans_handler = TransHandler.instance
      @drb_uri = Steinwies.config.server_uri
      super(:app => self, :validator => Validator.new, :trans_handler => SBSM::TransHandler.instance)
    end
  end
end
