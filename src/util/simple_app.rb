#!/usr/local/bin/ruby

require 'drb/drb'
SERVER_URI = 'druby://localhost:18999'

class CGI
  class Session
    class DRbSession
      def initialize(session, option={})
        puts "#{File.basename(__FILE__)}:#{__LINE__} initialize.new session #{session}"
        unless uri = option['drbsession_uri']
          raise ArgumentError, "drbsession_uri not specified"
        end

        unless DRb.thread
          DRb.start_service
        end

        holder = DRbObject.new(nil, uri)
        @obj = holder[session.session_id]
      end

      def restore
        puts "#{File.basename(__FILE__)}:#{__LINE__} restore"
        @obj.restore
      end
      def update
        puts "#{File.basename(__FILE__)}:#{__LINE__} update"
        @obj.update
      end
      def close
        puts "#{File.basename(__FILE__)}:#{__LINE__} close"
        @obj.close
      end
      def delete
        puts "#{File.basename(__FILE__)}:#{__LINE__} delete"
        @obj.delete
      end
    end
  end
end

# next simplied from sbsm/lib/sbsm/drbserver.rb
module SBSM
  COOKIE_ID = 'sbsm-persistent-cookie-id'
  class DRbServer # < SimpleDelegator
    include DRbUndumped
    def initialize(persistence_layer=nil)
      @sessions = {}
      puts "#{File.basename(__FILE__)}:#{__LINE__} DRbServer.new"
      @system = persistence_layer
      # super # (persistence_layer)
    end
    def process(request)
      res = "#{File.basename(__FILE__)}:#{__LINE__} process #{request} path: #{request.path} id: #{request.cookies[COOKIE_ID]}"
      puts res
      res
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
      # next from branch master of sbsm
      begin
        @cgi.params.store('default_flavor', ENV['DEFAULT_FLAVOR'])
        @request.notes.each { |key, val|
          @cgi.params.store(key, val)
        }
        drb_process()
      rescue StandardError => e
        handle_exception(e)
      ensure
        @session.close if @session.respond_to?(:close)
      end
    end
    def drb_process(sbsm_request)
      puts "#{File.basename(__FILE__)}:#{__LINE__} drb_process #{sbsm_request}"
      @request_path ||= sbsm_request.request.path
      puts "session.rb 165 XX request_path is #{@request_path}"
      #from branch master
      args = {
        'database_manager'  =>  CGI::Session::DRbSession,
        'drbsession_uri'    =>  @drb_uri,
        'session_path'      =>  '/',
      }
      check_threads
      if is_drop?
        return
      end
      if(is_crawler?)
        sleep 2.0
        sid = [ENV['DEFAULT_FLAVOR'], @cgi.params['language'], @cgi.user_agent].join('-')
        args.store('session_id', sid)
      end
      @session = CGI::Session.new(@cgi, args)
      @proxy = @session[:proxy]
      res = @proxy.drb_process(self)
      cookie_input = @proxy.cookie_input
      # view.to_html can call passthru instead of sending data
      if(@passthru)
        unless(cookie_input.empty?)
          cookie = generate_cookie(cookie_input)
          @request.headers_out.add('Set-Cookie', cookie.to_s)
        end
        basename = File.basename(@passthru)
        fullpath = File.expand_path(
          @passthru,
          @request.server.document_root.untaint)
        subreq = @request.lookup_file(fullpath)
        @request.content_type = subreq.content_type
        @request.headers_out.add('Content-Disposition',
          "#@disposition; filename=#{basename}")
        @request.headers_out.add('Content-Length',
          File.size(fullpath).to_s)
        begin
          File.open(fullpath) { |fd| @request.send_fd(fd) }
        rescue Errno::ENOENT, IOError => err
          @request.log_reason(err.message, @passthru)
          return Apache::NOT_FOUND
        end
      else
        begin
          headers = @proxy.http_headers
          unless(cookie_input.empty?)
            cookie = generate_cookie(cookie_input)
            headers.store('Set-Cookie', cookie.to_s)
          end
          @cgi.out(headers) {
            (@cgi.params.has_key?("pretty")) ? CGI.pretty( res ) : res
          }
        rescue StandardError => e
          handle_exception(e)
        end
      end
      if false #
      @session_counter += 1
      @@global_counter += 1
      process(sbsm_request)
      end
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

# next simplied from steinwies.ch/src/util/app
class Simple < SBSM::DRbServer
  SESSION = Session
  def to_s
    res = "#{File.basename(__FILE__)}:#{__LINE__} Im the Steinwies DrbServer!"
    puts res
    res
  end
end

  class PassThrough
    @@counter = 0
    def initialize(app)
      @app = Simple.new
      puts "#{File.basename(__FILE__)}:#{__LINE__} initialize @app is now #{@app.inspect}"
    end
    def call(env) ## mimick sbsm/lib/app.rb
      request = Rack::Request.new(env)
      puts "#{File.basename(__FILE__)}:#{__LINE__} cookies are #{request.cookies}"
      session_id = request.cookies[SBSM::COOKIE_ID]
      session_id =  Random.rand.to_s if request.cookies[SBSM::COOKIE_ID].length <= 1
      puts "#{File.basename(__FILE__)}:#{__LINE__} _session_id is #{session_id}"
      if /favicon.ico/i.match(request.path)
        return [400, {}, []]
      end
      saved = request.cookies['old_path']
      puts "#{File.basename(__FILE__)}:#{__LINE__} found session_id #{session_id} @session_handler is_? #{@session_handler.class}"
      @@counter += 1
      response = Rack::Response.new
      cgi_handler = DRbObject.new_with_uri(SERVER_URI)
      result = cgi_handler.process(request)
      puts "result is #{result.inspect} session_id #{session_id}"
      @@counter += 1
      # [200, {}, ["Hello World <br> We moved from #{saved}. now at #{request.path}"]]
      response.set_cookie(SBSM::COOKIE_ID, {:value => session_id, :path => "/", :expires => Time.now+24*60*60})
      # require 'pry'; binding.pry
      response.set_cookie('@@counter', {:value => @@counter, :path => "/", :expires => Time.now+24*60*60})
      response.set_cookie('old_path', {:value => request.path, :path => "/", :expires => Time.now+24*60*60})
      response.finish
    end
  end
