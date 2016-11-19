# frozen_string_literal: true

# Gathers error values from dry-validation objects
class ValidationError
  attr_reader :errors

  def initialize(validation)
    @errors = validation.errors.values.flatten
  end
end
