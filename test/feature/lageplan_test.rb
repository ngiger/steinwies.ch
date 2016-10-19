#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'

class SteinwiesTest <  Minitest::Test
  def test_lageplan_page_has_sub_title
    get '/de/page/lageplan'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    found = page.css('td').find_all{|td| /Wie Sie uns finden:/.match(td.text) }
    assert_equal 2, found.size
  end
end
