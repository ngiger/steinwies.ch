#!/usr/local/bin/ruby

require 'drb/drb'
SERVER_URI = 'druby://localhost:10999'

# next simplied from sbsm/lib/sbsm/drbserver.rb
module SBSM
  class DRbServer < SimpleDelegator
    def initialize(persistence_layer=nil)
      puts "#{File.basename(__FILE__)}:#{__LINE__} DRbServer.new"
      @system = persistence_layer
      super(persistence_layer)
    end
  end
end

# next simplied from sbsm/lib/sbsm/drbserver.rb
module SBSM
  class Session < SimpleDelegator
    @@global_counter = 0
    def initialize(key, app, validator=nil)
      puts "#{File.basename(__FILE__)}:#{__LINE__} Session.new #{key} #{app.class}"
      @session_counter = -5
    end
    def process(sbsm_request)
      puts "#{File.basename(__FILE__)}:#{__LINE__} drb_process #{sbsm_request}"
    end
    def drb_process(sbsm_request)
      puts "#{File.basename(__FILE__)}:#{__LINE__} drb_process #{sbsm_request}"
      @request_path ||= sbsm_request.request.path
      puts "session.rb 165 XX request_path is #{@request_path}"
      @session_counter += 1
      @@global_counter += 1
      process(sbsm_request)
      html = "#{File.basename(__FILE__)}:#{__LINE__} @session_counter #{@session_counter} @@global_counter #{@@global_counter}"
    rescue  => err
        puts "Error in drb_process #{err.backtrace[0..5].join("\n")}"
        raise err
    end
  end
end

# next simplied from steinwies.ch/src/session/app
class Session < SBSM::Session
  SERVER_NAME      = 'localhost:8999'
#  DEFAULT_LANGUAGE = 'de'
#  DEFAULT_STATE    = HomeState
#  DEFAULT_ZONE     = 'page'
#  LOOKANDFEEL      = Lookandfeel

  def initialize(key, app, validator=Validator.new)
    super
  end

  def flavor
    nil
  end

  def zone
    DEFAULT_ZONE
  end
end

# next simplied from steinwies.ch/src/util/app
class Simple < SBSM::DRbServer
  SESSION = Session
  def to_s
    "Im the Steinwies DrbServer!"
  end
end

  class PassThrough
    attr_accessor :session_pool
    @@counter = 0
    COOKIE_ID = 'sbsm-persistent-cookie-id'
    def initialize(app)
      @app = Simple.new
      puts "#{File.basename(__FILE__)}:#{__LINE__} initialize @app is now #{@app.inspect}"
      @session_pool = Rack::Session::Pool.new(@app, :domain => 'foo.com', :expire_after => 2592000  )
    end
    def call(env)
      request = Rack::Request.new(env)
      puts "#{File.basename(__FILE__)}:#{__LINE__} cookies are #{request.cookies}"
      puts "#{File.basename(__FILE__)}:#{__LINE__} _session_id is #{request.cookies[COOKIE_ID]} or #{request.session.id.inspect}"
      if /favicon.ico/i.match(request.path)
        return [400, {}, []]
      end
      saved = request.cookies['old_path']
      response = Rack::Response.new [
        "Hello World from #{__FILE__}:#{__LINE__} \n",
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
