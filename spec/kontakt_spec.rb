#!/usr/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe "steinwies.ch Homepage" do
 
  before :all do
    # waitForSteinwiesToBeReady(browser, SteinwiesUrl)
  end

  before :each do
    browser.goto SteinwiesUrl
  end

  it "should show the kontakt form" do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 8 # seconds – default is 60
    browser.goto SteinwiesUrl + '/de/page/kontakt'
    text = browser.text.clone
    expect(text).to match(/Bitte schreiben Sie hier Ihren Feedbacktex/)
    fields = browser.text_fields.collect{|x| x.name}
    expect(fields.index('email')).not_to be_nil
    expect(fields.index('vorname')).not_to be_nil
    expect(fields.index('text')).not_to be_nil
    browser.text_field(:name, 'email').set('niklaus.giger@member.fsf.org')
    browser.text_field(:name, 'ort').set('8753 Mollis')
    browser.textarea(:name, 'text').set('Adding Some Text')
    confirm =  browser.button(:name => 'confirm')
    expect(confirm).not_to be_nil
    # here the browser hangs as it tries to connect to port 8004 which is for production. Not for testing
    confirm.click
    expect(browser.title).not_to match /Problem loading page/i
    sendmail = browser.button(:name => 'sendmail')
    sendmail.wait_until_present(5)
    sendmail.click
    text = browser.text.clone
    expect(text).to match(/Ihre Nachricht wurde erfolgreich gesendet/)
    # we cannot test here the Mail::TestMailer.deliveries, because we are running in a different process
  end

end
