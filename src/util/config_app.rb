# Steinwies::App -- steinwies -- 03.12.2002 -- benfay@ywesee.com

require 'sbsm/drbserver'
require 'steinwies'
require 'util/config'
require 'util/session'
require 'util/trans_handler.steinwies'
require 'util/config'

module Steinwies
  class App
  end
  class PassThrough
    attr_accessor :session_pool
    @@counter = 0
    COOKIE_ID = 'sbsm-persistent-cookie-id'
    def initialize(app)
      @app = App.new
      puts "initialize @app is now #{@app.inspect}"
      @session_pool = Rack::Session::Pool.new(@app, :domain => 'foo.com', :expire_after => 2592000  )
    end
    def call(env)
      request = Rack::Request.new(env)
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
