# frozen_string_literal: true

# Represents any kind of error for interface output
class ErrorPresenter < Roar::Decorator
  collection :errors

  def to_interface_message
    @represented.errors.join('; ')
  end
end
