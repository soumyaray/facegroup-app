# frozen_string_literal: true

# GroupAPI web service
class Groupster < Sinatra::Base
  get '/group/?' do
    @data = GetAllGroups.call

    slim :group
  end

  get '/group/:id/?' do
    # result = FindGroup.call(params)
    #
    # if result.success?
    #   GroupRepresenter.new(result.value).to_json
    # else
    #   ErrorRepresenter.new(result.value).to_status_response
    # end
  end

  # Body args (JSON) e.g.: {"url": "http://facebook.com/groups/group_name"}
  post '/group/?' do
    url_request = UrlRequest.call(params)
    result = CreateNewGroup.call(url_request)

    if result.success?
      puts "SUCCESS: #{result.value}"
    else
      error_presenter = ErrorPresenter.new(result.value)
      puts "ERROR: #{error_presenter.to_interface_message}"
    end

    redirect '/group'
  end
end
