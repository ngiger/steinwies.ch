require 'test_helper'

# /de/lageplan
class LageplanTest < Minitest::Test
  include Steinwies::TestCase

  def setup
    browser.visit('/de/lageplan')
  end

  def test_page_has_sub_title
    assert_match('/de/lageplan', browser.url)

    title = wait_until { browser.td(class: 'subtitle') }
    assert_equal('Wie Sie uns finden:', title.text)
  end
end
