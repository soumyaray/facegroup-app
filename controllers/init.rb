# frozen_string_literal: true
require 'sinatra'
require 'slim/include'
require 'econfig'
require 'http'
require 'rack-flash'

require_relative 'base'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
