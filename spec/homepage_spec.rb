# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
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

  describe 'Page elements' do
    it '(HAPPY) should see website features' do
      # GIVEN
      @browser.goto homepage
      @browser.title.must_include 'Groupster'
      @browser.h1.text.must_include 'Groupster'

      # THEN
      @browser.button(name: 'new_group').visible?.must_equal true
    end

    it '(HAPPY) should see content' do
      # GIVEN
      @browser.goto homepage

      # THEN
      @browser.trs(class: 'groups_row').count.must_be :>=, 1
      @browser.span(class: 'group_name').text.must_include 'Service'
      @browser.span(class: 'group_url').text.must_include 'facebook'
    end

    it '(HAPPY) should be able open the new group modal' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: click on 'new group'
      @browser.button(name: 'new_group').click

      # THEN: should see elements in modal window
      Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
      @browser.input(id: 'fb_group_url_input').visible?.must_equal true
      @browser.button(id: 'group-form-submit').visible?.must_equal true
    end
  end

  describe 'Adding a group' do
    it '(HAPPY) should be able to add a real group' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: add a valid group url
      @browser.button(name: 'new_group').click
      Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
      @browser.text_field(id: 'fb_group_url_input').set(NEW_GROUP_URL)
      @browser.button(id: 'group-form-submit').click

      # THEN: group should be present on homepage
      group_url_span = @browser.spans(class: 'group_url').last
      group_url_span.text.must_include 'analytics'
      group_url_span.a.href.must_include 'http'
      group_url_span.a.href.must_include 'analytics'
      group_name_span = @browser.spans(class: 'group_name').last
      group_name_span.text.must_include 'Analytics'

      # and danger flash notice should be seen
      flash_notice = @browser.div(class: 'alert')
      flash_notice.text.must_include 'added'
      flash_notice.attribute_value('class').must_include 'success'
    end

    it '(SAD) should alert user if adding existing group' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: add an existing group url
      @browser.button(name: 'new_group').click
      Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
      @browser.text_field(id: 'fb_group_url_input').set(EXISTS_GROUP_URL)
      @browser.button(id: 'group-form-submit').click

      # THEN: danger flash notice should be seen
      flash_notice = @browser.div(class: 'alert')
      flash_notice.text.must_include 'exists'
      flash_notice.attribute_value('class').must_include 'danger'
    end

    it '(SAD) should alert user if incorrect URL given' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: add an invalid group url
      @browser.button(name: 'new_group').click
      Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
      @browser.text_field(id: 'fb_group_url_input').set(INVALID_GROUP_URL)
      @browser.button(id: 'group-form-submit').click

      # THEN: danger flash notice should be seen
      flash_notice = @browser.div(class: 'alert')
      flash_notice.attribute_value('class').must_include 'danger'
    end

    it '(SAD) should alert user if unresolvable URL given' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: add a badly formed group url
      @browser.button(name: 'new_group').click
      Watir::Wait.until { @browser.div(class: 'modal-dialog').visible? }
      @browser.text_field(id: 'fb_group_url_input').set(BAD_GROUP_URL)
      @browser.button(id: 'group-form-submit').click

      # THEN: danger flash notice should be seen
      flash_notice = @browser.div(class: 'alert')
      flash_notice.attribute_value('class').must_include 'danger'
    end
  end
end
