# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'steinwies'
require 'util/config'
require 'util/session'
require 'util/trans_handler.steinwies'
require 'util/config'
require 'pry'

module Steinwies
  class App < SBSM::DRbServer
    SESSION = Session
    attr_accessor :session_pool
    @@counter = 0
    COOKIE_ID = 'sbsm-persistent-cookie-id'
    def initialize
      @app = self
      @session_pool = Rack::Session::Pool.new(@app, :domain => 'foo.com', :expire_after => 2592000  )
      @sbsm = SBSM::Request.new(Steinwies.config.server_uri, Steinwies::TransHandler.instance, {})
      @validator = Steinwies::Validator.new
    end
    def call(env)
      @sbsm = SBSM::Request.new(Steinwies.config.server_uri, Steinwies::TransHandler.instance, {})
      @sbsm.request = Rack::Request.new(env)
      @sbsm.session = Rack::Session::Abstract::SessionHash.find(@sbsm.request)
      @sbsm.request.session.merge! env
      puts "call env #{env.keys} cookie_id #{@sbsm.request.cookies[COOKIE_ID]}"
      session = SESSION.new(@sbsm.request.cookies[COOKIE_ID], self, @validator)
      @sbsm.request.session[:proxy] = session
      response = @sbsm.process
      puts response.class
      puts "res1 #{response.status} with length #{response.body.join('').length} headers #{response.headers}"
      response.headers.delete('Content-Length')
      puts "res2 #{response.status} with length #{response.body.join('').length} headers #{response.headers}"
      return response.finish
      if false
        puts "cookies are #{request.cookies}"
        puts "_session_id is #{request.cookies[COOKIE_ID]} or #{request.session.id.inspect}"
        if /favicon.ico/i.match(request.path)
          return [400, {}, []]
        end
        saved = request.cookies['old_path']
        response = Rack::Response.new [
          "Hello World\n",
          "ID: #{request.cookies[COOKIE_ID] ? request.cookies[COOKIE_ID] : 'neue Session' }\n",
          "counter #{@@counter}\n",
          "We moved from #{saved}. now at #{request.path}"], 200, {}

        session = Rack::Session::Abstract::SessionHash.find(request)
        puts "found session #{session}"
        @@counter += 1
        [200, {}, ["Hello World <br> We moved from #{saved}. now at #{request.path}"]]

        response.set_cookie(COOKIE_ID, {:value => request.cookies[COOKIE_ID], :path => "/", :expires => Time.now+24*60*60})
        response.set_cookie('@@counter', {:value => @@counter, :path => "/", :expires => Time.now+24*60*60})
        response.set_cookie('old_path', {:value => request.path, :path => "/", :expires => Time.now+24*60*60})
        response.finish
      end
    end
  end
end
