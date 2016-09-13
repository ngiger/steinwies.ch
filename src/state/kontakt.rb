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
      if mail.ready?
        ConfirmState.new(@session, mail)
      else
        mail.errors.push(:email)
        @model = mail
        self
      end
    end
  end
end
