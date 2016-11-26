# frozen_string_literal: true
folders = 'models,values,representers,view_objects,forms,services,controllers'
Dir.glob("./{#{folders}}/init.rb").each do |file|
  require file
end
