# Navbar -- steinwies -- 19.11.2002 -- benfay@ywesee.com

require 'htmlgrid/link'
require 'htmlgrid/composite'

module Steinwies
  class NavLink  < HtmlGrid::Link

    def init
      super
      @attributes.store('href', @lookandfeel.event_url(nil, @name)) \
        unless @lookandfeel.direct_event == @name
      @attributes['class'] = 'nav'
    end

    def to_html(context)
      context.a(@attributes) { @lookandfeel.lookup(@name) }
    end
  end

  class Navbar < HtmlGrid::Composite
    CSS_CLASS  = 'nav'
    NAVIGATION = %i{
      home
      person
      schwerpunkte
      dissertation
      lageplan
      kontakt
    }
    SYMBOL_MAP = {
      :home         => NavLink,
      :person       => NavLink,
      :schwerpunkte => NavLink,
      :dissertation => NavLink,
      :lageplan     => NavLink,
      :kontakt      => NavLink,
    }

    def init
      @components = {}
      self::class::NAVIGATION.each_with_index { |symbol, index|
        x = index * 2
        @components[[x, 0]]     = symbol
        @components[[x - 1, 0]] = 'divider' if(x > 0)
      }
      super
    end
  end
end
