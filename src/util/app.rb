# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'sbsm/app'
require 'steinwies'
require 'util/config'
require 'util/session'
require 'util/trans_handler.steinwies'
require 'util/config'
require 'util/app'

module Steinwies
  class AppWebrick < SBSM::App
    SESSION = Session
    attr_reader :trans_handler, :validator, :drb_uri
    def initialize(persistence_layer=nil)
      SBSM.logger= ChronoLogger.new(Steinwies.config.log_pattern)
      SBSM.info "Steinwies::AppWebrick.new with log_pattern #{Steinwies.config.log_pattern} #{SBSM.logger.level}"
      SBSM.logger.level = :info
      @validator = Validator.new
      @trans_handler = TransHandler.instance
      @drb_uri = Steinwies.config.server_uri
      super(:app => self, :validator => Validator.new, :trans_handler => SBSM::TransHandler.instance)
    end
  end
end
