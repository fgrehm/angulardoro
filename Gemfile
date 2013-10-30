source 'https://rubygems.org'

gem 'rails', '4.0.0'
# Keep an eye on new releases, this was required in order to use strong_parameters
gem 'rails-api', github: 'rails-api/rails-api'
gem 'puma'
gem 'sqlite3'

group :development do
  gem 'seedbank', '0.3.0.pre2'
  gem 'guard',          require: false
  gem 'guard-rspec',    require: false
  gem 'guard-teaspoon', require: false
  gem 'rb-inotify',     require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner', require: false
  gem 'fabrication'
  gem 'faker'
  gem 'teaspoon'
end

group :assets do
  gem 'coffee-rails'
end
