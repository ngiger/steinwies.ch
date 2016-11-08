#!/usr/bin/env ruby
# encoding: utf-8
require 'spec_helper'

@workThread = nil

describe "ch.oddb.org" do
 
  before :all do
    @idx = 0
    waitForSteinwiesToBeReady(@browser, SteinwiesUrl)
  end

  before :each do
    @browser.goto SteinwiesUrl
  end

  it "should show the homepage" do
    text = @browser.text.clone
    expect(text).to match(/Praxisgemeinschaft Steinwies/)
  end

  it "should show contain a link to dissertation" do
    text = @browser.text.clone
    expect(text).to match(/Dissertationen/)
  end

  after :all do
    stop_steinwies_and_browser
  end

end
