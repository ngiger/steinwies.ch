#!/usr/bin/env ruby
# encoding: utf-8
# require 'simplecov'
# SimpleCov.start

RSpec.configure do |config|
  config.mock_with :flexmock
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

BreakIntoPry = false
begin
  require 'pry'
rescue LoadError
  # ignore error for Travis-CI
end
$LOAD_PATH << File.join(File.dirname(File.dirname(__FILE__)), 'src')

require 'page-object'
require 'fileutils'
require 'page-object'
require 'fileutils'
require 'pp'
require "watir-webdriver/wait"

require 'steinwies'
require 'util/app'
require 'sbsm/logger'
require 'tst_util'

if RUBY_PLATFORM.match(/mingw/)
  require 'watir'
  browsers2test = [ :ie ]
else
  browsers2test ||= [ ENV['ODDB_BROWSER'] ] if ENV['ODDB_BROWSER']
  browsers2test = [ :chrome ] unless browsers2test and browsers2test.size > 0 # could be any combination of :ie, :firefox, :chrome
  require 'watir-webdriver'
end
Browser2test = browsers2test

def setup_steinwies
  SBSM.info msg = "Starting #{Steinwies.config.server_uri}"
  puts Steinwies.config.server_uri
  @pid = Process.spawn('bundle', 'exec', 'rackup', 'spec/config.ru', { :err => ['app_spec.log', 'w+'], :out => ['app_spec.log', 'a+']})
  DRb.start_service(TEST_APP_URI.to_s, Steinwies::AppWebrick.new)
  sleep(0.1)
end

def stop_steinwies_and_browser
  puts "stop_steinwies_and_browser @pid: #{@pid} browser #{@browser}"
  @browser.close if @browser
  if @pid
    Process.kill("HUP", @pid)
    Process.wait(@pid)
  end
end

def setup_browser
  return if @browser
  if Browser2test[0].to_s.eql?('firefox')
    puts "Setting upd default profile for firefox"
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.download.folderList'] = 2
    profile['browser.helperApps.alwaysAsk.force'] = false
    profile['browser.helperApps.neverAsk.saveToDisk'] = "application/zip;application/octet-stream;application/x-zip;application/x-zip-compressed;text/csv;test/semicolon-separated-values"

    @browser = Watir::Browser.new :firefox, :profile => profile
  elsif Browser2test[0].to_s.eql?('chrome')
    puts "Setting up a default profile for chrome"
    Selenium::WebDriver::Chrome.driver_path =  File.exist?('/usr/bin/google-chrome-stable') ?
      '/usr/bin/google-chrome-stable' :'/usr/lib64/chromium-browser/chromedriver'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" =>
                                                            {

                                                            "args" =>
                                                             [ "--disable-web-security" ,
                                                               '--no-sandbox',
                                                               '--no-default-browser-check',
                                                               '--no-first-run',
                                                               '--disable-default-apps',
                                                               ]})
    driver = Selenium::WebDriver.for :chrome,
        :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate],
        desired_capabilities: caps
    prefs = {
      :download => {:prompt_for_download => false, }
    }
    @browser = Watir::Browser.new driver, :prefs => prefs
  elsif Browser2test[0].to_s.eql?('ie')
    puts "Trying unknown browser type Internet Explorer"
    @browser = Watir::Browser.new :ie
  else
    puts "Trying unknown browser type #{Browser2test[0]}"
    @browser = Watir::Browser.new Browser2test[0]
  end
end

def login(user = ViewerUser, password=ViewerPassword, remember_me=false)
  setup_browser
  @browser.goto SteinwiesUrl
  sleep 0.5
  sleep 0.5 unless @browser.link(:name =>'login_form').exists?
  return true unless  @browser.link(:text=>'Anmeldung').exists?
  @browser.link(:text=>'Anmeldung').when_present.click
  @browser.text_field(:name, 'email').when_present.set(user)
  @browser.text_field(:name, 'pass').when_present.set(password)
  # puts "Login with #{@browser.text_field(:name, 'email').value} and #{@browser.text_field(:name, 'pass').value}"
  if remember_me
    @browser.checkbox(:name, "remember_me").set
  else
    @browser.checkbox(:name, "remember_me").clear
  end
  @browser.button(:name,"login").click
  sleep 1 unless @browser.button(:name,"logout").exists?
  if  @browser.button(:name,"login").exists?
    @browser.goto(SteinwiesUrl)
    return false
  else
    return true
  end
end

def get_session_timestamp
  @@timestamp ||= Time.now.strftime('%Y%m%d_%H%M%S')
end

def logout
  setup_browser
  @browser.goto SteinwiesUrl
  sleep(0.1) unless @browser.link(:name=>'logout').exists?
  logout_btn = @browser.link(:name=>'logout')
  return unless  logout_btn.exists?
  logout_btn.click
end

def waitForSteinwiesToBeReady(browser = nil, url = SteinwiesUrl, maxWait = 30)
  setup_steinwies
  setup_browser
  startTime = Time.now
  @seconds = -1
  0.upto(maxWait).each{
    |idx|
   @browser.goto SteinwiesUrl; small_delay
    unless /Es tut uns leid/.match(@browser.text)
      @seconds = idx
      break
    end
    if idx == 0
      $stdout.write "Waiting max #{maxWait} seconds for #{url} to be ready"; $stdout.flush
    else
      $stdout.write('.'); $stdout.flush
    end
    sleep 1
  }
  endTime = Time.now
  sleep(0.2)
  @browser.link(:text=>'Plus').click if @browser.link(:text=>'Plus').exists?
  puts "Took #{(endTime - startTime).round} seconds for for #{SteinwiesUrl} to be ready. First answer was after #{@seconds} seconds." if (endTime - startTime).round > 2
end

def small_delay
  sleep(0.1)
end
