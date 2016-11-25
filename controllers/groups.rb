# frozen_string_literal: true

# Groupster web application
class Groupster < Sinatra::Base
  # Home page: show list of all groups
  get '/?' do
    result = GetAllGroups.call
    if result.success?
      @data = result.value
      puts @data
    else
      flash[:error] = result.value.message
    end

    slim :groups
  end

  # Add a new Facebook group to our systems
  post '/groups/?' do
    url_request = UrlRequest.call(params)
    result = CreateNewGroup.call(url_request)

    if result.success?
      flash[:notice] = 'Group successfully added'
    else
      flash[:error] = result.value.message
    end

    redirect '/'
  end

  get '/groups/:id/?' do
    # TODO: get postings and information from a single group
    group_details = GetGroupDetails.call(params)
    if group_details.success?
      @group = group_details.value
      slim :group
    else
      flash[:error] = 'Could not find that group -- we are investigating!'
      redirect '/'
    end
  end
end
