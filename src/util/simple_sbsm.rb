#!/usr/local/bin/ruby

require 'drb/drb'
require 'util/validator'
require 'sbsm/logger'
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
    SBSM.info "Session #{app}"
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
  attr_reader :trans_handler
  def initialize
    SBSM.info "SimpleSBSM.new"
    # @validator = nil
      @trans_handler = nil
    super(nil)
  end
end

  class PassThrough
    @@counter = 0
    attr_reader :request, :trans_handler
    PERSISTENT_COOKIE_NAME = 'passthrough-cookie-id2'
    def initialize(app, validator = nil)
      @app = app
      @trans_handler = nil
      SBSM.info "initialize @app is now #{@app.inspect}"
    end
    def call(env) ## mimick sbsm/lib/app.rb
      request = Rack::Request.new(env)
      SBSM.info "cookies are #{request.cookies}"
      if request.cookies[PERSISTENT_COOKIE_NAME] && request.cookies[PERSISTENT_COOKIE_NAME].length > 1
        session_id = request.cookies[PERSISTENT_COOKIE_NAME]
      else
        session_id = rand((2**(0.size * 8 -2) -1)*10240000000000).to_s(16)
      end

      return [400, {}, []] if /favicon.ico/i.match(request.path)
      saved = request.cookies['old_path']
      SBSM.info "found session_id #{session_id} @session_handler is_? #{@session_handler.class}"
      @@counter += 1
      response = Rack::Response.new
      # result = DRbObject.new_with_uri(SERVER_URI).process(request)
      @drb_uri = SERVER_URI
      args = {
        'database_manager'  =>  CGI::Session::DRbSession,
        'drbsession_uri'    =>  @drb_uri,
        'session_path'      =>  '/',
      }
      @cgi = CGI.initialize_without_offline_prompt('html4')
      @session = CGI::Session.new(@cgi, args)
      @proxy = @session[:proxy]
      res = @proxy.drb_process(self, request)
      html = response.write(res)
      response.write html
      response.write "\nPassthrough (WebRick PID) is #{Process.pid}"
      response.write "\n@@counter is #{@@counter}"
      response.write "\nsession_id is #{session_id}"
      # [200, {}, ["Hello World <br> We moved from #{saved}. now at #{request.path}"]]
      response.set_cookie(PERSISTENT_COOKIE_NAME, {:value => session_id, :path => "/", :expires => Time.now+24*60*60})
      response.set_cookie('@@counter', {:value => @@counter, :path => "/", :expires => Time.now+24*60*60})
      response.set_cookie('old_path', {:value => request.path, :path => "/", :expires => Time.now+24*60*60})
      response.finish
    end
  end
end