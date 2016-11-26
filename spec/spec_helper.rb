# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require 'vcr'
require 'webmock'

require 'watir-webdriver'
require 'headless'
require 'page-object'

require './init.rb'

include Rack::Test::Methods

def app
  Groupster
end

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
EMPTY_CASSETTE = 'empty_api'
DATA_CASSETTE = 'data_api'

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock
end

HAPPY_GROUP_URL = 'https://www.facebook.com/groups/ISS.SOAD'
SAD_GROUP_URL = 'https://www.facebook.com/groups/whatisthisidonteven'
BAD_GROUP_URL = 'htt://www.facebook'
