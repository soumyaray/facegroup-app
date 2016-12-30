# frozen_string_literal: true
class AllGroupsView
  attr_reader :groups, :channel_id, :api_url

  def initialize(all_groups, channel_id=nil, api_url=nil)
    @groups = all_groups.groups.map { |group| GroupDescriptionView.new(group) }
    @channel_id = channel_id
    @api_url = api_url
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
