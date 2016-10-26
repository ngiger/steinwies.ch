#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
$stdout.sync = true
puts __LINE__
require 'minitest/autorun'
puts __LINE__
require 'test_helper'
puts __LINE__
require 'nokogiri'
puts __LINE__

class SteinwiesTest <  Minitest::Test
puts __LINE__
  include Rack::Test::Methods
puts __LINE__
  def test_dissertation_has_flyer_links
puts __LINE__
    addresses = {
    '/resources/pdf/3FlyerMM.pdf' => /Flyer\s+\(Pdf/,
    '/resources/pdf/4MM_Deprivation.pdf' => /Deprivation\s+\(PDF,/,
    '/resources/pdf/Dissertation_Teil_1_14.08.00_aktualisiert_10.2.2009.pdf' => /Dissertation Teil1\s+\(Pdf/,
    '/resources/pdf/chart_von_m_meierhofer.pdf' => /Dissertation Teil2\s+\(Pdf/,
      }
puts __LINE__
    get '/de/page/dissertation'
puts __LINE__
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    addresses.each do |ressource, pattern|
      found = page.css('a').find{|a|  CGI.unescapeHTML(a.attributes['href'].to_s).eql?(ressource)}
      assert found, "must find #{ressource}"
      assert_match pattern, found.text
    end
  end
end
