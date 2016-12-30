# frozen_string_literal: true

# Groupster web application
class Groupster < Sinatra::Base
  # Home page: show list of all groups -- ignore any running tasks
  get '/?' do
    result = GetAllGroups.call(params)
    if result.success?
      @data = AllGroupsView.new(result.value)
    else
      flash[:error] = result.value.message
    end

    slim :all_groups
  end

  # Handles redirect from POST /groups/ and creates progress bar
  post '/?' do
    result = GetAllGroups.call(params)
    if result.success?
      @data = AllGroupsView.new(
        result.value, params['channel_id'], Groupster.config.API_SERVER)
    else
      flash[:error] = result.value.message
    end

    slim :all_groups
  end

  # Add a new Facebook group to our systems
  post '/groups/?' do
    url_request = UrlRequest.call(params)
    result = CreateNewGroup.call(url_request)

    if result.success?
      flash[:notice] = 'Importing Facebook Group'
      redirect "/?channel_id=#{result.value['channel_id']}", 307
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end

  get '/groups/:id/?' do
    group_details = GetGroupDetails.call(params)
    if group_details.success?
      group_postings = group_details.value
      @group = GroupDetailsView.new(group_postings)
      slim :group_details
    else
      flash[:error] = 'Could not find that group -- we are investigating!'
      redirect '/'
    end
  end
end
