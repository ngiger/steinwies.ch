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
      puts "env with session #{request.session} is #{request.session.id.inspect}"
      saved = request.session[:old_path]
      puts "cookies are #{request.cookies}"
      puts "_session_id is #{request.cookies[COOKIE_ID]} or #{request.session.id.inspect}"
      session = Rack::Session::Abstract::SessionHash.find(request)
      puts "found session #{session}"
      @@counter += 1
      puts "session ID is #{request.session.id.inspect}"
      [200, {}, ["Hello World <br> We moved from #{saved}. now at #{request.path}"]]
      headers = {}
    response = Rack::Response.new [
      "Hello World\nID:",
      "#{request.session.id} counter #{@@counter}",
      "\nWe moved from #{saved}. now at #{request.path}"], 200, headers

    response.set_cookie(COOKIE_ID, {:value => request.cookies[COOKIE_ID], :path => "/", :expires => Time.now+24*60*60})
    response.set_cookie('@@counter', {:value => @@counter, :path => "/", :expires => Time.now+24*60*60})
    response.set_cookie('old_path', {:value => saved, :path => "/", :expires => Time.now+24*60*60})
    response.finish # finish writes out the response in the expected form
    end
  end
end
if false
  myapp = MyRackApp.new
  sessioned = Rack::Session::Pool.new(myapp,
    :domain => 'foo.com',
    :expire_after => 2592000
  )
  Rack::Handler::WEBrick.run sessioned

end
