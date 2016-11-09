require 'sbsm/trans_handler'

module Steinwies
end

module Steinwies
  class TransHandler < SBSM::TransHandler
    # SBSM::TransHandler's default simple_parse method expects
    # following uri:
    #     /language/flavor/event/key/value/key/value/...
    # steinwies.ch does not use flavor, but it has zone without key
    # like this:
    #     /language/[ZONE]/event/key/value/key/value/...
    #
    # This method provides support for this old uri format, wich
    # was implemented as 'zone_uri' grammer by using rockit.
    def simple_parse(uri)
      items = uri.split('/')
      items.shift
      values = {}
      lang = items.shift
      values.store(:language, lang) if lang
      # NOTE:
      #   steinwies.ch does not have actually `zone`.
      #   But other applications need zone. Therefore steinwies.ch also use
      #   pseuedo `zone`.
      zone = items.shift
      values.store(:zone, zone) if zone
      event = items.shift
      values.store(:event, event) if event
      until items.empty?
        key   = items.shift
        value = items.shift
        values.store(key, value)
      end
      values
    end
  end
end
