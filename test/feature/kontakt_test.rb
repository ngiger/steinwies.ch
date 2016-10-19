#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'minitest/autorun'
require 'test_helper'
require 'nokogiri'

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

  patterns = [ /^name/,
                /^vorname/,
                /^firma/,
                /^adresse/,
                /^ort/,
                /^telefon/,
                /^bestell_diss/,
                /^bestell_pedi/,
                ]
  patterns = [ 'name',
                'vorname',
               ]
  patterns.each do |pattern|
    pattern_test(pattern)
    # eval("test_kontakt_pat_#{pattern} #{pattern}")
  end if false

  def test_kontakt_has_form_elements
    get '/de/page/kontakt'
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    patterns = [ /^name/,
                  /^vorname/,
                  /^firma/,
                  /^adresse/,
                  /^ort/,
                  /^telefon/,
                  /^bestell_diss/,
                  /^bestell_pedi/,
                  ]
    # patterns= [/resetxxx/]
    patterns.each do |pattern|
      # puts "Checking for #{pattern}"
      # found = page.css('td').find_all{|td| td.children && td.children.size >= 2 && td.children[1].name.eql?('input')  && pattern.match(td.children[1].attributes['name'].value) }
      found = get_input_field(page, pattern)
      # require 'pry'; binding.pry
      assert_equal 1, found.size, "Must find input with name #{pattern}"
    end
    assert_equal 1, page.css('textarea').size, 'must have a text area'
    textarea = page.css('textarea').first
    assert_equal 'text', textarea.attributes['name'].value
  end

  def test_kontakt_submit_kontakt
    # get '/de/page/kontakt'
    # assert last_response.ok?
    # page = Nokogiri::HTML(last_response.body)

    post "/de/page/kontakt"
    assert last_response.ok?
    page = Nokogiri::HTML(last_response.body)
    # post "/photos", "file" => Rack::Test::UploadedFile.new("me.jpg", "image/jpeg")
  end
  def test_kontakt_hello_form_post
    # email=ngiger%40ywesee.com&anrede=Herr&name=Giger&vorname=Niklaus&firma=&adresse=Wieshoschet+6&ort=8753+Mollis&telefon=&bestell_diss=&bestell_pedi=
    #&confirm=Weiter&text=Test-Mail.+Bitte+ignorieren&flavor=&language=en&event=confirm&state_id=69945621979720
    result =   post '/hello/', params={:email => 'test@user.org',
                                       :anrede => "Herr",
                                       :name => 'Bond',
                                       :vorname => 'James',
                                       :telefon => '',
                                       :firma=> '',
                                       :ort => '1234 name',
                                       :bestell_diss => '',
                                       :bestell_pedi => '',
                                       :confirm => 'Weiter',
                                       :text => 'Test-Mail. Bitte ignorieren',
                                       :flavor => '',
                                       :language => 'en',
                                       :event => 'confirm',
                                       :state_id => '69945621979720',
                                       }
    assert_equal 'application/x-www-form-urlencoded', last_response.headers['Content-Type']
    expected =
        [ /^sbsm-persistent-cookie=language\%3Den$/,
          /^_session_id=[0-9a-f]+$/,
          ]
    # expected.each{|pattern] assert last_response.headers['Cookie'].find{|x| pattern.match(x) }
    assert last_response.ok?
    assert last_response.body.include?('I just wanted to say')
  end
end

