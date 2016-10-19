# KontaktState -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'state/global_predefine'
require 'view/kontakt'
require 'util/kontaktmail'

module Steinwies
  class KontaktState < GlobalState
    DIRECT_EVENT = :kontakt
    VIEW         = Kontakt

    def confirm
      mail = KontaktMail.new(@session)
      puts "confirm #{mail.inspect} #{mail.ready?.inspect}"
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
