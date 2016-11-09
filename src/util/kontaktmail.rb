# KontaktMail -- Steinwies -- 04.12.2010 -- zdavatz@ywesee.com added sending through Google TLS lines 57-58
# KontaktMail -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'mail'
require 'util/config'
require 'state/global_predefine'
require 'view/kontakt'

module Steinwies
  class KontaktMail
    attr_accessor :errors
    attr_reader :email, :anrede, :name, :vorname, :firma, :adresse, :ort,
                :telefon, :bestell_diss, :bestell_pedi, :text
    options = {
        :address => Steinwies.config.mailer['server'],
        :port => Steinwies.config.mailer['port'],
        :domain => Steinwies.config.mailer['domain'],
        :user_name => Steinwies.config.mailer['user'],
        :password => Steinwies.config.mailer['pass'],
        :authentication => Steinwies.config.mailer['auth'],
        :enable_starttls_auto => true,
      }
    Mail.defaults do
      delivery_method :smtp, options
    end

    def initialize(session)
      @errors       = []
      @session      = session
      @email        = @session.user_input(:email)
      @anrede       = @session.user_input(:anrede)
      @name         = @session.user_input(:name)
      @vorname      = @session.user_input(:vorname)
      @firma        = @session.user_input(:firma)
      @adresse      = @session.user_input(:adresse)
      @ort          = @session.user_input(:ort)
      @telefon      = @session.user_input(:telefon)
      @bestell_diss = @session.user_input(:bestell_diss)
      @bestell_pedi = @session.user_input(:bestell_pedi)
      @text         = @session.user_input(:text)
    end

    def body
      width = 25
      body = []
      body << 'Email-Adresse:'.ljust(width) + @email
      body << 'Anrede:'.ljust(width) + @anrede
      body << 'Name:'.ljust(width) + @name
      body << 'Vorname:'.ljust(width) + @vorname
      body << 'Firma:'.ljust(width) + @firma
      body << 'Adresse:'.ljust(width) + @adresse
      body << 'Ort:'.ljust(width) + @ort
      body << 'Telefon:'.ljust(width) + @telefon
      body << 'Bestellung Dissertion:'.ljust(width) + @bestell_diss
      body << 'Bestellung Pädiatrie:'.ljust(width) + @bestell_pedi
      body << 'Ihre Mitteilung:'.ljust(width) + @text
      body.join("\n")
    end

    def error?(key)
      @errors.include?(key)
    end

    def ready?
      unless @email
        false
      else
        true
      end
    end

    def do_sendmail
      my_var = body
      Mail.deliver do
        to Steinwies.config.mailer['to'].join(',')
        from Steinwies.config.mailer['from']
        subject 'Email von Deiner Webseite.'
        html_part do
        content_type 'text/html; charset=UTF-8'
          body my_var
        end
      end
      SBSM.info "SentMail  #{body.size}"
    end
  end
end
