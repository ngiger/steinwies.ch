# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'util/config'
require 'util/session'

module Steinwies
  class App < SBSM::DRbServer
    SESSION = Session
  end
end
