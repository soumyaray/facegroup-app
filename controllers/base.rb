# frozen_string_literal: true

configure :development do
  def reload!
    # Tux reloading: https://github.com/cldwalker/tux/issues/3
    exec $PROGRAM_NAME, *ARGV
  end
end

# configure based on environment
class Groupster < Sinatra::Base
  extend Econfig::Shortcut

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end

  after do
    content_type 'text/html'
  end

  get '/?' do
    slim :home
  end
end
