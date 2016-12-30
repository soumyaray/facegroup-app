# frozen_string_literal: true

# Represents overall group information for JSON API output
class WSChannelRepresenter < Roar::Decorator
  include Roar::JSON

  property :channel_id
end
