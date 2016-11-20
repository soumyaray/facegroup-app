# frozen_string_literal: true

# Represents any kind of error for interface output
class ErrorFlattener < Roar::Decorator
  collection :errors

  def to_s
    @represented.errors.join('; ')
  end
end
