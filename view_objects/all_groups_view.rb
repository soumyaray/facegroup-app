# frozen_string_literal: true
class AllGroupsView
  attr_reader :groups

  def initialize(all_groups)
    @groups = all_groups.groups.map { |group| GroupDescriptionView.new(group) }
  end
end

class GroupDescriptionView
  attr_reader :id, :name, :fb_url, :updates

  def initialize(group)
    @id = group.id
    @name = group.name
    @fb_url = group.fb_url
    @updates = report_updates(group.updates)
  end

  def report_updates(updates)
    if updates&.success?
      count = updates.value.postings.count
      "(#{count} new)" if count.positive?
    end
  end
end
