# frozen_string_literal: true

# Gets list of all groups from API
class GetGroupUpdates
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    result = HTTP.get("#{Groupster.config.FACEGROUP_API}/group/#{params[:id]}/news")
    Right(PostingsSearchResultsRepresenter.new(PostingsSearchResults.new)
                                          .from_json(result.body.to_s))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
