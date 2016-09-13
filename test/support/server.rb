require 'webrick'
require 'sbsm/request'
require 'util/trans_handler.steinwies'

class Object
  def meta_class; class << self; self; end; end
  def meta_eval &blk; meta_class.instance_eval &blk; end
end


module WEBrick
  class HTTPServer
    attr_accessor :document_root

    def log_warn(*args)
    end

    def log_notice(*args)
    end
  end

  class HTTPRequest
    attr_accessor :server, :uri, :notes

    alias :__old_initialize__ :initialize

    def initialize(*args)
      __old_initialize__(*args)
      @notes = Steinwies::Notes.new
    end

    def headers_in
      headers = {}
      if @header
        @header.each { |key, vals| headers.store(key, vals.join(';')) }
      end
      headers
    end

    def uri
      @uri || unparsed_uri
    end

    def content_length
      return Integer(self['content-length'] || '0')
    end
  end

  class HTTPResponse
    attr_accessor :rawdata

    alias :__old_send_header__ :send_header

    def send_header(socket)
      if @rawdata
        _write_data(socket, status_line)
      else
        __old_send_header__(socket)
      end
    end

    alias :__old_setup_header__ :setup_header

    def setup_header()
      unless @rawdata
        __old_setup_header__
      end
    end
  end
end

module SBSM
  class Request

    def handle_exception(e)
      raise e
    end
  end

  module Apache
    DECLINED = nil

    def Apache.request=(request)
      @request = request
    end

    def Apache.request
      @request
    end
  end
end

class CGI
  attr_accessor :output

  def stdoutput
    output
  end

  public :env_table
end

module Steinwies
  class Notes < Hash
    alias :add :store
  end

  class Output < String
    alias :write :<<
    alias :print :<<
  end

  def self.http_server(drburi)
    doc = File.expand_path('../../doc', File.dirname(__FILE__))
    server_args = {
      :Port         => TEST_SRV_URI.port,
      :BindAddress  => TEST_SRV_URI.host,
      :DocumentRoot => doc,
      :Logger       => WEBrick::Log.new('/dev/null'),
      :AccessLog    => []
    }
    if DEBUG
      server_args[:Logger]    = WEBrick::Log.new($stdout)
      server_args[:AccessLog] = nil
    end
    server = WEBrick::HTTPServer.new(server_args)
    # for SBSM::TransHandler
    server.document_root = doc

    app = Proc.new do |req, resp|
      resp.chunked = true
      if req.uri =~ /\.css\z/
        resp.body = ''
      elsif req.uri == '/favicon.ico'
        resp.body = File.open(File.join(doc, req.uri))
      else
        req.server = server
        TransHandler.instance.translate_uri(req)
        # Not Threadsafe!
        SBSM::Apache.request = req
        output = Output.new
        sbsm = SBSM::Request.new(drburi)
        sbsm.meta_eval { define_method(:handle_exception) { |e| raise e } }
        sbsm.cgi.params.update(req.query)
        sbsm.cgi.env_table['SERVER_NAME'] = \
          "#{TEST_SRV_URI.host}:#{TEST_SRV_URI.port}"
        sbsm.cgi.env_table['REQUEST_METHOD'] = req.request_method
        sbsm.cgi.env_table['CONTENT_LENGTH'] = req.content_length.to_s
        sbsm.cgi.cookies['_session_id'] = 'test:preset-session-id'
        sbsm.cgi.output = output
        sbsm.process
        if /^location:/i.match(output)
          resp.status = 303
        end
        resp.rawdata = true
        resp.body = output
      end
    end

    server.mount_proc('/', &app)
    server.mount_proc('/en', &app)
    server.mount_proc('/en/.*', &app)
    res = File.join(doc, 'resources')
    server.mount('/resources',
      WEBrick::HTTPServlet::FileHandler, res, {})
    server
  end
end
