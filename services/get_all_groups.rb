# frozen_string_literal: true

# Gets list of all groups from API
class GetAllGroups
  def self.call
    results = HTTP.get("#{Groupster.config.FACEGROUP_API}/group")
    GroupsRepresenter.new(Groups.new).from_json(results.body)
  end
end
