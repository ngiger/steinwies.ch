# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'util/config'
require 'util/session'
# require 'rack/show_exceptions'

module Rack
  class SteinwiesApp < SBSM::DRbServer
    SESSION = Steinwies::Session
    def call(env)
      # require 'pry'; binding.pry
      puts "config.server_uri is #{Steinwies.config.server_uri}"
      # require 'pry'; binding.pry
      sbsm = SBSM::Request.new(Steinwies.config.server_uri, env)
      res = sbsm.process
      puts "result #{__LINE__}"
      puts "#{Time.now}: path #{sbsm.request.env['REQUEST_PATH']} Finished length #{sbsm.response.body.to_s.size}"
      x = res.finish
      puts "res #{__LINE__}"
      puts "done finish"
      return sbsm.response.finish
    end
    def not_returned
      rescue  => err
        puts "#{__FILE__}: #{__LINE__} zz"
        puts err.backtrace[0,5]
        response = Rack::Response.new
        response.status =  500
        response.finish
    end
  end
end
