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

  pending "should show the kontakt form" do
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
    if true
      fail 'Dont push problematic button'
    else
      # here the browser hangs as it tries to connect to port 8004 which is for production. Not for testing
      confirm.click
      expect(browser.title).not_to match /Problem loading page/i
      browser.button(:name => 'confirm').wait_until_present(5)
      text = browser.text.clone
      expect(text).to match(/Bitte schreiben Sie hier Ihren Feedbacktex/)
    end
  end

end
