# KontaktState -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/kontakt'
require 'util/kontaktmail'

module Steinwies
  class KontaktState < GlobalState
    DIRECT_EVENT = :kontakt
    VIEW         = Kontakt

    def initialize(session, model)
      puts "state/kontakt.rb #{__LINE__} Steinwies init #{session.class} model #{model.class}"
      super(session, model)
    end
    def confirm
      binding.pry
      mail = KontaktMail.new(@session)
      puts "state/kontakt.rb #{__LINE__} confirm #{mail.inspect} #{mail.ready?.inspect}"
      if mail.ready?
        ConfirmState.new(@session, mail)
      else
        puts "Pushed error"
        mail.errors.push(:email)
        @model = mail
        self
      end
    end
  end
end
