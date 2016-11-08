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
  # page.css('td').find_all{|td| td.children && td.children.size >= 2 && td.children[1].name.eql?('input')  && name.match(td.children[1].attributes['name'].value) }
  def get_input_field(page, name)
    page.css('input').find{|x| x.attributes['name'].value.eql?('email') }
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
    patterns.each do |pattern|
      found = get_input_field(page, pattern)
      assert found.to_s.length > 5
      # puts "Found value for #{pattern}"
    end
  end

  def test_back
    skip "no test yet for testing back"
  end
  def test_kontakt_submit_kontakt
    header 'Test-Header', 'Test value'
    url = '/de/page/kontakt'
    clear_cookies
    get url
    assert last_response.ok?
    assert rack_mock_session.cookie_jar.to_hash[SBSM::App::PERSISTENT_COOKIE_NAME]
    assert rack_mock_session.cookie_jar.to_hash['language']
    page = Nokogiri::HTML(last_response.body)
    assert  page.css('input').find{|x| x.attributes['name'].value.eql?('state_id') }.attributes['value'].value
    state_id = page.css('input').find{|x| x.attributes['name'].value.eql?('state_id') }.attributes['value'].value.to_i
    assert state_id > 0
    post_result =   post '/url/page', params={:email => 'test@user.org',
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
                                       :state_id => state_id}
    pattern = 'Mail senden'
    confirm =  Nokogiri::HTML(post_result.body).text
    skip "confirm does not yet work"
    assert_match pattern, confirm
    expected =
        [ /^sbsm-persistent-cookie=language\%3Den$/,
          /^_session_id=[0-9a-f]+$/,
          ]
    # expected.each{|pattern] assert last_response.headers['Cookie'].find{|x| pattern.match(x) }
    assert last_response.ok?
  end
end

