# frozen_string_literal: true
require 'dry-validation'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
