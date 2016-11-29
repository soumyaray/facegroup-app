# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
  before do
    unless @browser
      @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'Page elements' do
    include PageObject::PageFactory

    it '(HAPPY) should see website features' do
      # GIVEN: user goes to the home page
      visit GroupsPage do |page|
        # THEN: user should see correct title, header, 'next page' button
        page.title.must_include 'Groupster'
        page.heading.must_include 'Groupster'

        page.new_group?
      end
    end

    it '(HAPPY) should see content' do
      # GIVEN: user goes to the homepage
      visit GroupsPage do |page|
        # THEN: user should see a row with group information and links
        page.groups_count.must_be :>=, 1
        page.first_row.link_element.text.must_include 'Service'
        page.first_row.link_element.href.must_include 'groups'
        page.first_row.fb_link_element.href.must_include 'facebook'
      end
    end

    it '(HAPPY) should be able open the new group modal' do
      # GIVEN: on the homepage
      visit GroupsPage do |page|
        # WHEN: click on 'new group'
        page.new_group

        # THEN: should see elements in modal window
        page.wait_for_new_group_modal
        page.new_group_input_element.visible?.must_equal true
        page.new_group_submit_element.visible?.must_equal true
      end
    end
  end

  describe 'Adding a group' do
    include PageObject::PageFactory

    it '(HAPPY) should be able to add a real group' do
      # GIVEN: on the homepage
      visit GroupsPage do |page|
        # WHEN: add a valid group url
        page.add_new_group_url(NEW_GROUP_URL)

        # THEN: group should be present on homepage
        page.last_row.link_element.text.must_include 'Analytics'
        page.last_row.fb_link_element.href.must_include 'https'
        page.last_row.fb_link_element.href.must_include 'analytics'
        page.last_row.fb_link_element.text.must_include 'analytics'

        # THEN: and danger flash notice should be seen
        page.flash_notice.must_include 'added'
        page.flash_notice_element.attribute(:class).must_include 'success'
      end
    end

    it '(SAD) should alert user if adding existing group' do
      # GIVEN: on the homepage
      visit GroupsPage do |page|
        # WHEN: add an existing group url
        page.add_new_group_url(EXISTS_GROUP_URL)

        # THEN: danger flash notice should be seen
        page.flash_notice.must_include 'exists'
        page.flash_notice_element.attribute(:class).must_include 'danger'
      end
    end

    it '(SAD) should alert user if incorrect URL given' do
      # GIVEN: on the homepage
      visit GroupsPage do |page|
        # WHEN: add an invalid group url
        page.add_new_group_url(INVALID_GROUP_URL)

        # THEN: danger flash notice should be seen
        page.flash_notice.must_include 'not recognized'
        page.flash_notice_element.attribute(:class).must_include 'danger'
      end
    end

    it '(SAD) should alert user if unresolvable URL given' do
      # GIVEN: on the homepage
      visit GroupsPage do |page|
        # WHEN: add an badly formed group url
        page.add_new_group_url(INVALID_GROUP_URL)

        # THEN: danger flash notice should be seen
        page.flash_notice_element.attribute(:class).must_include 'danger'
      end
    end
  end
end
