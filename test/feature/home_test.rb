#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'

class SteinwiesTest <  Minitest::Test
  def test_home_title
    get '/de/page/home'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    assert_match(/Praxis Steinwies/, page.title)
  end
  def test_home_mailto
    addresses = [
    'mailto:thea.altherr@bluewin.ch',
    'mailto:Praxis.gut@hin.ch',
    'mailto:daniel.marti@kispi.uzh.ch',
    'mailto:barbara.menn@bluewin.ch',
    'mailto:mmpopper@hotmail.com',
    'mailto:maja.wyss@steinwies.ch',
    ]
    get '/de/page/home'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    addresses.each do |addr|
      found = page.css('a').find do |a|  CGI.unescapeHTML(a.attributes['href'].to_s).eql?(addr) end
      assert found, "must find mailto #{addr}"
    end
  end
end

