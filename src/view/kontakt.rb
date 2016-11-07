# Kontakt -- steinwies -- 19.11.2002 -- benfay@ywesee.com

require 'htmlgrid/form'
require 'htmlgrid/inputtext'
require 'htmlgrid/textarea'
require 'htmlgrid/button'
require 'htmlgrid/staticinput'
require 'htmlgrid/submit'
require 'htmlgrid/reset'
require 'htmlgrid/text'
require 'view/template'
require 'util/lookandfeel'

module Steinwies
  class Bestellung < HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => 'buch_bestellen',
      [0, 1] => :bestell_diss,
      [0, 2] => :bestell_pedi,
    }
    LABELS  = true
    CSS_MAP = {
      [0, 0] => 'subtitle',
    }
    SYMBOL_MAP = {
      :bestell_diss => HtmlGrid::InputText,
      :bestell_pedi => HtmlGrid::InputText,
    }
  end

  class KontaktLeft < HtmlGrid::Composite
    COMPONENTS = {
      [0,  0] => :email,
      [0,  1] => :anrede,
      [0,  2] => :name,
      [0,  3] => :vorname,
      [0,  4] => :firma,
      [0,  5] => :adresse,
      [0,  6] => :ort,
      [0,  7] => :telefon,
      [0,  8] => Bestellung,
      [0,  9] => :confirm,
      [0, 10] => :reset,
    }
    COLSPAN_MAP = {
      [0, 8] => 2,
      [1, 9] => 2,
    }
    LABELS     = true
    SYMBOL_MAP = {
      :email   => HtmlGrid::InputText,
      :anrede  => HtmlGrid::InputText,
      :name    => HtmlGrid::InputText,
      :vorname => HtmlGrid::InputText,
      :firma   => HtmlGrid::InputText,
      :adresse => HtmlGrid::InputText,
      :ort     => HtmlGrid::InputText,
      :telefon => HtmlGrid::InputText,
      :confirm => HtmlGrid::Submit,
      :reset   => HtmlGrid::Reset,
    }

  end

  class KontaktRight < HtmlGrid::Composite
    COMPONENTS = {
      [0, 0] => :text,
    }
    SYMBOL_MAP = {
      :text => HtmlGrid::Textarea,
    }
  end

  class KontaktFrame < HtmlGrid::Form
    COMPONENTS = {
      [0, 0] => 'kontakt_title',
      [2, 0] => 'feedbacktext',
      [0, 1] => KontaktLeft,
      [2, 1] => KontaktRight,
    }
    CSS_MAP = {
      [0, 0] => 'subtitle',
    }
    EVENT = :confirm

    def init
      super
      if @model.respond_to?(:error?) && @model.error?(:email)
        new_content = HtmlGrid::Text.new(
          :error_message, @model, @session, self)
        @grid.insert_row(1, new_content)
      end
      # require 'pry'; binding.pry
    end
  end

  class Kontakt < Template
    CONTENT = KontaktFrame
  end
end
