# frozen_string_literal: true
require 'json'

# Represents overall group information for JSON API output
class ApiErrorRepresenter < Roar::Decorator
  include Roar::JSON

  collection :errors
end
