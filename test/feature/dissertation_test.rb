#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'

class SteinwiesTest <  Minitest::Test
  include Rack::Test::Methods
  def test_dissertation_has_flyer_links
    addresses = {
    '/resources/pdf/3FlyerMM.pdf' => /Flyer\s+\(Pdf/,
    '/resources/pdf/4MM_Deprivation.pdf' => /Deprivation\s+\(PDF,/,
    '/resources/pdf/Dissertation_Teil_1_14.08.00_aktualisiert_10.2.2009.pdf' => /Dissertation Teil1\s+\(Pdf/,
    '/resources/pdf/chart_von_m_meierhofer.pdf' => /Dissertation Teil2\s+\(Pdf/,
      }
    get '/de/page/dissertation'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    addresses.each do |ressource, pattern|
      found = page.css('a').find{|a|  CGI.unescapeHTML(a.attributes['href'].to_s).eql?(ressource)}
      assert found, "must find #{ressource}"
      assert_match pattern, found.text
    end
  end
end
