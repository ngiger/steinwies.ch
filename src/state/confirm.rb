# ConfirmState -- steinwies -- 08.01.2003 -- benfay@ywesee.com

require 'state/global_predefine'
require 'state/sent'
require 'view/confirm'

module Steinwies
  class ConfirmState < GlobalState
    DIRECT_EVENT = :confirm
    VIEW         = Confirm

    def sendmail
      @model.do_sendmail
      SentState.new(@session, nil)
    end

    def back
      KontaktState.new(@session, @model)
    end
  end
end
