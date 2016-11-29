# frozen_string_literal: true
require 'page-object'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
