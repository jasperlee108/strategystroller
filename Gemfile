source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Active Admin
gem 'activeadmin'
gem 'sass-rails'
gem "meta_search",    '>= 1.1.0.pre'
gem 'coffee-script-source', '~> 1.4.0'

#Twitter Bootstrap
gem "twitter-bootstrap-rails"

gem 'formtastic-bootstrap'
gem 'tabulous'

## Assume deploying to heroku, use Rspec
gem 'rspec-rails', '2.12.2'

## For local development and testing, use sqlite3 as dBase
## On local machine, do "bundle install --without production"
group :development, :test do
  gem 'sqlite3'
end

## For deployment to heroku, use postgreSQL
## Capycabara is a fix for Rspec mentioned in CS169 website 
#group :production do
  #gem 'pg'
  #gem 'capybara', '1.1.2'
#end

gem 'json'

#For authentication:
gem 'devise'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
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
