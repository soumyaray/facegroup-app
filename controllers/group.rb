# frozen_string_literal: true

# Groupster web application
class Groupster < Sinatra::Base
  # Home page: show list of all groups
  get '/?' do
    result = GetAllGroups.call
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end

    slim :group
  end

  # Add a new Facebook group to our systems
  post '/group/?' do
    url_request = UrlRequest.call(params)
    result = CreateNewGroup.call(url_request)

    if result.success?
      flash[:notice] = 'Group successfully added'
    else
      flash[:error] = result.value.message
    end

    redirect '/'
  end

  get '/group/:id/?' do
    # TODO: get postings and information from a single group
  end
end
