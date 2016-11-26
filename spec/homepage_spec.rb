# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
  before do
    VCR.insert_cassette EMPTY_CASSETTE, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it '(HAPPY) It should see basic homepage' do
    
  end
end
