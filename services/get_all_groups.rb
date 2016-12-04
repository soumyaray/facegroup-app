# frozen_string_literal: true

# Gets list of all groups from API
class GetAllGroups
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :get_all_groups
      step :optionally_get_updates
    end.call(params)
  end

  register :get_all_groups, lambda { |params|
    begin
      results = HTTP.get("#{Groupster.config.FACEGROUP_API}/group")
      Right(groups: GroupsRepresenter.new(Groups.new).from_json(results.body),
            params: params)
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :optionally_get_updates, lambda { |all_groups|
    begin
      if action_wanted?(all_groups[:params], :update)
        updates = async_group_updates(all_groups[:groups])
        Right(updated_groups(all_groups[:groups], updates))
      else
        Right(all_groups[:groups])
      end
    rescue
      Left(Error.new('Could not get updates at this time'))
    end
  }

  private_class_method

  def self.action_wanted?(params, action)
    params[:action] == action.to_s
  end

  def self.find_group_updates(groups_repr)
    groups_repr.groups.map do |group|
      GetGroupUpdates.call(group.id)
    end
  end

  def self.async_group_updates(groups_repr)
    promised_updates = groups_repr.groups.map do |group|
      Concurrent::Promise.execute { GetGroupUpdates.call(group.id) }
    end
    promised_updates.map(&:value)
  end

  def self.updated_groups(groups, updates)
    updates.each do |update|
      group = groups.groups.find { |grp| grp.id == update.value.id }
      group.updates = update
    end
    groups
  end
end
