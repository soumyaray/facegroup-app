# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'

EXISTS_GROUP_URL = 'https://www.facebook.com/groups/ISS.SOAD'
NEW_GROUP_URL = 'https://www.facebook.com/groups/nthu.analytics'
INVALID_GROUP_URL = 'https://www.facebook.com/groups/that_does_not_exist404'
BAD_GROUP_URL = 'htt://www.facebook'

HOST = 'http://localhost:9000/'

# Helper methods
def homepage
  HOST
end

def group_details_page(id)
  "#{HOST}/groups/#{id}"
end
