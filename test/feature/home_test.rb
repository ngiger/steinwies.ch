require 'test_helper'

# /de/home
class HomeTest < Minitest::Test
  include Steinwies::TestCase

  def setup
    browser.visit('/de/home')
  end

  def test_page_has_address_as_title
    title = wait_until { browser.td(class: 'title') }
    assert_match(/Steinwiesstr\.\s37/, title.text)
  end

  def test_page_has_valid_email_links
    assert_match('/de/home', browser.url)

    link = wait_until { browser.a(href: 'mailto:thea.altherr@bluewin.ch') }
    assert(link.exists?)
    link = wait_until { browser.a(href: 'mailto:Praxis.gut@hin.ch') }
    assert(link.exists?)
    link = wait_until { browser.a(href: 'mailto:daniel.marti@kispi.uzh.ch') }
    assert(link.exists?)
    link = wait_until { browser.a(href: 'mailto:barbara.menn@bluewin.ch') }
    assert(link.exists?)
    link = wait_until { browser.a(href: 'mailto:mmpopper@hotmail.com') }
    assert(link.exists?)
    link = wait_until { browser.a(href: 'mailto:maja.wyss@steinwies.ch') }
    assert(link.exists?)
  end
end
