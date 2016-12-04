# frozen_string_literal: true
require_relative 'posting'

# Represents overall group information for JSON API output
class GroupDetailsRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :name
  property :fb_url
  collection :postings, extend: PostingRepresenter, class: Posting
end
