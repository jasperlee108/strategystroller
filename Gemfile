source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

## Assume deploying to heroku, use Rspec
gem 'rspec-rails', '2.12.2'

## For local development and testing, use sqlite3 as dBase
## On local machine, do "bundle install --without production"
group :development, :test do
  gem 'sqlite3'
end

## For deployment to heroku, use postgreSQL
## Capycabara is a fix for Rspec mentioned in CS169 website 
group :production do
  gem 'pg'
  gem 'capybara', '1.1.2'
end

gem 'json'
gem 'omniauth'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'
