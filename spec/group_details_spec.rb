# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Group Details Page' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  it '(HAPPY) should see rows of postings' do
    @browser.goto group_details_page(1)
    @browser.trs(class: 'group_row').count.must_be :>=, 10
    first_row = @browser.trs(class: 'group_row').first
    first_row.img(class: 'group_media').visible?.must_equal true
  end
end
