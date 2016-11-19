# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewGroup
  extend Dry::Monads::Either::Mixin

  def self.call(url_request)
    if url_request.success?
      result = HTTP.post(
        "#{Groupster.config.FACEGROUP_API}/group",
        json: { url: url_request[:group_url] }
      )
      return_result(result.status, result.body.to_s)
    else
      Left(ValidationError.new(url_request))
    end
  end

  private_class_method

  def self.return_result(status, data)
    if status == 200
      Right(GroupRepresenter.new(Group.new).from_json(data))
    else
      Left(ApiErrorRepresenter.new(ApiError.new).from_json(data))
    end
  end
end
