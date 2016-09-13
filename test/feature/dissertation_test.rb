require 'test_helper'

# /de/dissertation
class DissertationTest < Minitest::Test
  include Steinwies::TestCase

  def setup
    browser.visit('/de/dissertation')
  end

  def test_page_has_flyer_links
    assert_match('/de/dissertation', browser.url)

    link = wait_until { browser.a(href: '/resources/pdf/3FlyerMM.pdf') }
    assert_equal("Flyer\n(Pdf, 46 Kb)", link.text)

    link = wait_until { browser.a(href: '/resources/pdf/4MM_Deprivation.pdf') }
    assert_equal("Deprivation\n(PDF, 3 Mb)", link.text)

    link = wait_until { browser.a(href:
      '/resources/pdf/Dissertation_Teil_1_14.08.00_aktualisiert_10.2.2009.pdf') }
    assert_equal("Dissertation Teil1\n(Pdf, 825 Kb)", link.text)

    link = wait_until { browser.a(href:
      '/resources/pdf/chart_von_m_meierhofer.pdf') }
    assert_match("Dissertation Teil2\n(Pdf, 994 Kb)", link.text)
  end
end
