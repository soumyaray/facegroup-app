# frozen_string_literal: true

# Gets list of all groups from API
class GetGroupUpdates
  extend Dry::Monads::Either::Mixin

  def self.call(group_id)
    result = HTTP.get("#{Groupster.api_ver_url}/group/#{group_id}/news")
    Right(PostingsSearchResultsRepresenter.new(PostingsSearchResults.new)
                                          .from_json(result.body.to_s))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
