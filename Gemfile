source 'https://rubygems.org'

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use simple calendar
gem "simple_calendar", "~> 2.4"

# Adding and removing foreign key constraints
gem 'foreigner'

# Hashing password
gem 'bcrypt'

# Use Unicorn as the app server
# gem 'unicorn'

gem 'themoviedb'

# Window support
gem 'tzinfo'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'rspec-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'database_cleaner'
  gem 'cucumber-rails', require: false
  # gem 'cucumber-rails-training-wheels'

  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'guard-rspec'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.6'

  gem 'brakeman'
  gem 'bundler-audit'
  gem 'robocop'
end

group :test do
  gem 'simplecov', :require => false
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg', '~> 0.21' # for Heroku deployment
  gem 'rails_12factor'
end
