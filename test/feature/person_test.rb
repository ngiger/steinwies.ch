#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'

class SteinwiesTest <  Minitest::Test
  def test_person_person_has_sub_title
    get '/de/page/person'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    patterns = [ /Zu meiner Person/,
                 /Beruflicher Werdegang/,
                 /Berufliche Erfahrungen/
                 ]
    patterns.each do |pattern|
      found = page.css('td').find_all{|td| td.attributes['class'] && td.attributes['class'].value.eql?('subtitle') && pattern.match(td.text) }
      assert_equal 1, found.size, "Must find subtitle #{pattern}"
    end
  end
  def test_person_has_doctor_name_as_title
    get '/de/page/person'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    found = page.css('td').find_all{|td| td.attributes['class'] && td.attributes['class'].value.eql?('title') && /Dr. phil. Maja Wyss-Wanner/.match(td.text) }
    assert_equal 1, found.size
  end
end
