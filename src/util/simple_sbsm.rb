#!/usr/local/bin/ruby

require 'drb/drb'
require 'util/validator'
require 'sbsm/session'

Validator = Steinwies::Validator
SERVER_URI = 'druby://localhost:18998'

require 'sbsm/drbserver'

# next simplied from steinwies.ch/src/util/app
module Steinwies

# next simplied from steinwies.ch/src/session/app
class Session < SBSM::Session
  SERVER_NAME      = 'localhost:8998'
#  DEFAULT_LANGUAGE = 'de'
#  DEFAULT_STATE    = HomeState
#  DEFAULT_ZONE     = 'page'
#  LOOKANDFEEL      = Lookandfeel

  def initialize(key, app, validator=Validator.new)
    puts "#{File.basename(__FILE__)}:#{__LINE__} Session #{app}"
    super
  end

  def flavor
    nil
  end

  def zone
    DEFAULT_ZONE
  end
end

class SimpleSBSM < SBSM::DRbServer
  SESSION = Session
  # attr_accessor :validator
  def initialize
    puts "#{File.basename(__FILE__)}:#{__LINE__} SimpleSBSM.new"#  persistence_layer #{persistence_layer.inspect}"
    # @validator = nil
    super(nil)
  end
  def to_s
    res = "#{File.basename(__FILE__)}:#{__LINE__} Im the Steinwies DrbServer from the pid #{Process.pid}"
    puts res
    res
  end
end

  class PassThrough
    @@counter = 0
    attr_reader :request, :trans_handler
    PERSISTENT_COOKIE_NAME = 'passthrough-cookie-id'
    def initialize(app, validator = nil)
      @app = app
      @trans_handler = nil
      puts "#{File.basename(__FILE__)}:#{__LINE__} initialize @app is now #{@app.inspect}"
    end
    def call(env) ## mimick sbsm/lib/app.rb
      request = Rack::Request.new(env)
      puts "#{File.basename(__FILE__)}:#{__LINE__} cookies are #{request.cookies}"
      session_id = request.cookies[PERSISTENT_COOKIE_NAME]
      session_id =  Random.rand.to_s unless request.cookies[PERSISTENT_COOKIE_NAME] && request.cookies[PERSISTENT_COOKIE_NAME].length > 1
      puts "#{File.basename(__FILE__)}:#{__LINE__} _session_id is #{session_id}"
      if /favicon.ico/i.match(request.path)
        return [400, {}, []]
      end
      saved = request.cookies['old_path']
      puts "#{File.basename(__FILE__)}:#{__LINE__} found session_id #{session_id} @session_handler is_? #{@session_handler.class}"
      @@counter += 1
      response = Rack::Response.new
      # result = DRbObject.new_with_uri(SERVER_URI).process(request)

      session = @app[session_id]
      @request = request
      result = session.process(self)
      puts "result is #{result.inspect} session_id #{session_id} WebRick has pid #{Process.pid}"
      puts DRbObject.new_with_uri(SERVER_URI).to_s
      puts session.to_s
      # @proxy = DRbObject.new_with_uri(SERVER_URI)
      @proxy =  DRbObject.new(session, SERVER_URI)
      puts @proxy.to_s
      session.drb_process self # das läuft
      res = @proxy.drb_process(self) # das nicht
      html = @response.write(res)
      response.write html
      response.write "\nPassthrough (WebRick PID) is #{Process.pid}"
      response.write "\n@@counter is #{@@counter}"
      response.write "\nsession_id is #{session_id}"
      @@counter += 1
      # [200, {}, ["Hello World <br> We moved from #{saved}. now at #{request.path}"]]
      response.set_cookie(PERSISTENT_COOKIE_NAME, {:value => session_id, :path => "/", :expires => Time.now+24*60*60})
      # require 'pry'; binding.pry
      response.set_cookie('@@counter', {:value => @@counter, :path => "/", :expires => Time.now+24*60*60})
      response.set_cookie('old_path', {:value => request.path, :path => "/", :expires => Time.now+24*60*60})
      response.finish
    end
  end
end