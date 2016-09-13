require 'test_helper'

# /de/person
class PersonTest < Minitest::Test
  include Steinwies::TestCase

  def setup
    browser.visit('/de/person')
  end

  def test_page_has_doctor_name_as_title
    assert_match('/de/person', browser.url)

    title = wait_until { browser.td(class: 'title') }
    assert_equal('Dr. phil. Maja Wyss-Wanner', title.text)
  end

  def test_page_has_sub_titles
    assert_match('/de/person', browser.url)

    titles = browser.tds(class: 'subtitle').map(&:text)
    assert_equal('Zu meiner Person',       titles[0])
    assert_equal('Beruflicher Werdegang',  titles[1])
    assert_equal('Berufliche Erfahrungen', titles[2])
  end
end
