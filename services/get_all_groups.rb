# frozen_string_literal: true

# Gets list of all groups from API
class GetAllGroups
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{Groupster.config.FACEGROUP_API}/group")
    Right(GroupsRepresenter.new(Groups.new)
                           .from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
