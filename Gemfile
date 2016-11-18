# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

gem 'puma'
gem 'sinatra'
gem 'slim'
gem 'json'
gem 'econfig'
gem 'rake'

# gem 'roar'
# gem 'multi_json'
# gem 'dry-monads'
# gem 'dry-container'
# gem 'dry-transaction'

group :development do
  gem 'rerun'
  gem 'guard'
  gem 'guard-livereload'

  gem 'flog'
  gem 'flay'
end

group :test do
  gem 'minitest'
  gem 'minitest-rg'

  gem 'rack-test'

  gem 'vcr'
  gem 'webmock'
end

group :development, :production do
  gem 'tux'
end
