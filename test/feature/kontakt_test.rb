require 'test_helper'

# /de/page/kontakt
class KontaktTest < Minitest::Test
  include Steinwies::TestCase

  def setup
    browser.visit('/de/page/kontakt')
  end

  def test_page_has_title
    assert_match('/de/page/kontakt', browser.url)

    title = wait_until { browser.td(class: 'subtitle') }
    assert_equal('Kontakt', title.text)
  end

  def test_page_has_form_elements
    assert_match('/de/page/kontakt', browser.url)

    input = browser.text_field(name: 'email')
    assert(input.exists?)

    textarea = browser.textarea(name: 'text')
    assert(textarea.exists?)
  end

  # TODO
  # test (stub) server does not respond to request after POST...

  def test_validation_error
    # TODO
    # ssert_match('/de/page/kontakt', browser.url)

    #input = wait_until { browser.text_field(name: 'email') }
    #input.set('test@example.org')

    #button = browser.input(name: 'confirm')
    #button.fire_event('onclick')

    #assert_match('/de/page/kontakt', browser.url)
    #assert_match(/Ihre\sE\-Mail\sAdresse\swird\sbenötigt/, browser.text)
  end

  def test_confirmation
    # TODO
  end

  def test_email
    # TODO
  end
end
