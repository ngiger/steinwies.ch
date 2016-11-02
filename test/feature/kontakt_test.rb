#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'
require 'pry'

class SteinwiesTest < Minitest::Test
  def test_kontakt_has_sub_title
    get '/de/page/kontakt'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    patterns = [ /Kontakt/,
                 ]
    patterns.each do |pattern|
      found = page.css('td').find_all{|td| td.attributes['class'] && td.attributes['class'].value.eql?('subtitle') && pattern.match(td.text) }
      assert_equal 1, found.size, "Must find subtitle #{pattern}"
    end
  end
  def get_input_field(page, name)
    page.css('td').find_all{|td| td.children && td.children.size >= 2 && td.children[1].name.eql?('input')  && name.match(td.children[1].attributes['name'].value) }
  end

  def pattern_test(pattern)
    get '/de/page/kontakt'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    found = get_input_field(page, pattern)
    assert_equal 1, found.size, "Must find input with name #{pattern}"
    assert_equal 1, page.css('textarea').size, 'must have a text area'
    textarea = page.css('textarea').first
    assert_equal 'text', textarea.attributes['name'].value
  end

  def test_kontakt_has_form_elements
    get '/de/page/kontakt'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    assert_equal 1, page.css('textarea').size, 'must have a text area'
    textarea = page.css('textarea').first
    assert_equal 'text', textarea.attributes['name'].value
    patterns = [ /^name/,
                  /^vorname/,
                  /^firma/,
                  /^adresse/,
                  /^ort/,
                  /^telefon/,
                  /^bestell_diss/,
                  /^bestell_pedi/,
                  ]
    skip "form elements do not work correctly"
    patterns.each do |pattern|
      found = get_input_field(page, pattern)
      assert_equal 1, found.size, "Must find input with name #{pattern}"
    end
  end

  def test_kontakt_submit_kontakt
    header 'Test-Header', 'Test value'
    url = '/de/page/kontakt'
    clear_cookies
    get url
    assert last_response.ok?
    skip "submit in kontakt does not yet work"
    assert rack_mock_session.cookie_jar.to_hash['_session_id']
    puts  rack_mock_session.cookie_jar.to_hash['cookie-persistent-sbsm-1.3.1']
    page = Nokogiri::HTML(last_response.body)
    x = page.css('div')
    assert_equal 'state_id', x.children[7].attributes['name'].value
    state_id = x.children[7].attributes['value'].value
    post_result =   post url, params={:email => 'test@user.org',
                                       :anrede => "Herr",
                                       :name => 'Bond',
                                       :vorname => 'James',
                                       :telefon => '',
                                       :firma=> 'MI6',
                                       :ort => '1234 name',
                                       :bestell_diss => '',
                                       :bestell_pedi => '',
                                       :confirm => 'Weiter',
                                       :text => 'Test-Mail. Bitte ignorieren',
                                       :flavor => '',
                                       :language => 'en',
                                       # :event => 'confirm',
                                       :state_id => state_id}#,
    pattern = 'Mail senden'
    puts "_current_session_names are #{_current_session_names}"
    puts last_response.headers
    puts  last_request.url
    assert_equal true, last_response.body.include?(pattern), "Response body must include <#{pattern}>"
    assert_equal 'application/x-www-form-urlencoded', last_response.headers['Content-Type']
    expected =
        [ /^sbsm-persistent-cookie=language\%3Den$/,
          /^_session_id=[0-9a-f]+$/,
          ]
    # expected.each{|pattern] assert last_response.headers['Cookie'].find{|x| pattern.match(x) }
    assert last_response.ok?
  end
end

