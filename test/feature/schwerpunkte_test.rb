#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'

class SteinwiesTest <  Minitest::Test
  def test_page_schwerpunkt_has_sub_title
    get '/de/page/schwerpunkte'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    patterns = [ /Schwerpunkte meiner Arbeit/,
                 /Berufliche Werkzeuge/,
                 /Zur Finanzierung von Beratungen und Therapien/
                 ]
    patterns.each do |pattern|
      found = page.css('td').find_all{|td| td.attributes['class'] && td.attributes['class'].value.eql?('subtitle') && pattern.match(td.text) }
      assert_equal 1, found.size, "Must find subtitle #{pattern}"
    end
  end
end
