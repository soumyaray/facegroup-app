# frozen_string_literal: true
# folders = 'values,models,representers,queries,services,controllers'
folders = 'controllers'
Dir.glob("./{#{folders}}/init.rb").each do |file|
  require file
end
