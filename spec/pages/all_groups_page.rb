# frozen_string_literal: true

# Page object for all groups view (homepage)
class AllGroupsPage
  include PageObject

  page_url 'http://localhost:9000/'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  button(:new_group, name: 'new_group')
  table(:groups_table, id: 'groups_table')
  indexed_property(
    :groups,
    [
      [:a, :link, { id: 'group[%s].link' }],
      [:a, :fb_link, { id: 'group[%s].fb_link' }]
    ]
  )

  div(:new_group_modal, class: 'modal-dialog')
  text_field(:new_group_input, id: 'fb_group_url_input')
  button(:new_group_submit, id: 'group-form-submit')

  def groups_count
    browser.trs(class: 'groups_row').count
  end

  def first_row
    groups[0]
  end

  def last_row
    groups[groups_rows_count - 1] # zero index
  end

  def groups_rows_count
    groups_table_element.rows - 1 # without header
  end

  def wait_for_new_group_modal
    wait_until { new_group_modal_element.visible? }
  end

  def add_new_group_url(url)
    new_group
    wait_for_new_group_modal
    self.new_group_input = url
    new_group_submit
  end
end
