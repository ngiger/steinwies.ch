# KontaktMail -- Steinwies -- 04.12.2010 -- zdavatz@ywesee.com added sending through Google TLS lines 57-58
# KontaktMail -- Steinwies -- 04.12.2002 -- benfay@ywesee.com

require 'net/smtp'
require 'util/smtp_tls'
require 'util/config'
require 'state/global_predefine'
require 'view/kontakt'

module Steinwies
  class KontaktMail
    attr_accessor :errors
    attr_reader :email, :anrede, :name, :vorname, :firma, :adresse, :ort,
                :telefon, :bestell_diss, :bestell_pedi, :text

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
      body << 'Bestellung P&auml;diatrie:'.ljust(width) + @bestell_pedi
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
      smtp = Net::SMTP.new(Steinwies.config.mailer['server'])
      smtp.start(
        Steinwies.config.mailer['domain'],
        Steinwies.config.mailer['user'],
        Steinwies.config.mailer['pass'],
        Steinwies.config.mailer['auth']
      )
      smtp.ready(@email, Steinwies.config.mailer['to']) {  |a|
        a.write("Content-Type: text/plain; charset='UTF-8'\n")
        a.write("Subject: Email von Deiner Webseite.\n")
        a.write("\n")
        a.write(body)
      }
    end
  end
end
