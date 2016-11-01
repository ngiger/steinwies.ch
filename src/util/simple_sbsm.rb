#!/usr/local/bin/ruby
# Niklaus Giger, November 2016
# A simple example on how to use SBSM with webrick
require 'drb/drb'
require 'sbsm/logger'
require 'sbsm/session'
require 'sbsm/validator'
require 'sbsm/drbserver'
require 'state/global_predefine'

SERVER_URI = 'druby://localhost:18998'

# next simplied from steinwies.ch/src/util/app
module Steinwies
  class Validator < SBSM::Validator
    EVENTS = %i{
      home
    }
    STRINGS = %i{
    }
  end

  class HomeState < GlobalState
    @@class_counter = 0
    def initialize(arg1, arg2)
      @member_counter = 0
      super(arg1, arg2)
    end
    def to_html(cgi)
      @@class_counter += 1
      @member_counter += 1
      info = ["State is Home" ,
      "pid is #{Process.pid}",
      "request_path is #{@request_path}" ,
      "@member_counter is #{@member_counter}",
      "@@class_counter is #{@@class_counter}",
      ]
      puts info.join("\n  ")
      info.join("\n")
    end
  end

  # next simplied from steinwies.ch/src/session/app
  class Session < SBSM::Session
    SERVER_NAME      = 'localhost:8998'
    DEFAULT_STATE    = HomeState
    def initialize(key, app, validator=Validator.new)
      SBSM.info "Session #{app}"
      super
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

    def to_html
      SBSM.info "Some html"
      require 'pry'; binding.pry
      @counter += 1
      content = "to_html for #{self.class} is #{Process.pid}"
      # content += "\nsession_id is #{session_id}"
      content += "\n@counter is #{@counter}"
    end
  end
end