# Confirm -- steinwies -- 08.01.2003 -- benfay@ywesee.com

require 'htmlgrid/component'
require 'htmlgrid/text'
require 'htmlgrid/value'
require 'htmlgrid/form'
require 'htmlgrid/button'
require 'util/lookandfeel'
require 'view/template'

module Steinwies
  class ConfirmText < HtmlGrid::Form
    COMPONENTS = {
      [0,  0] => 'confirmtext',
      [0,  2] => :email,
      [0,  3] => :anrede,
      [0,  4] => :name,
      [0,  5] => :vorname,
      [0,  6] => :firma,
      [0,  7] => :adresse,
      [0,  8] => :ort,
      [0,  9] => :telefon,
      [0, 10] => :bestell_diss,
      [0, 12] => :bestell_pedi,
      [0, 13] => :text,
      [0, 14] => :submit,
      [0, 15] => :back,
    }
    EVENT  = :sendmail
    LABELS = true
    SYMBOL_MAP = {
      :email        => HtmlGrid::Value,
      :anrede       => HtmlGrid::Value,
      :name         => HtmlGrid::Value,
      :vorname      => HtmlGrid::Value,
      :firma        => HtmlGrid::Value,
      :adresse      => HtmlGrid::Value,
      :ort          => HtmlGrid::Value,
      :telefon      => HtmlGrid::Value,
      :bestell_diss => HtmlGrid::Value,
      :bestell_pedi => HtmlGrid::Value,
      :text         => HtmlGrid::Value,
      :back         => HtmlGrid::Button,
    }
  end

  class Confirm < Template
    CONTENT = ConfirmText

    def init
      super
    end
  end
end
