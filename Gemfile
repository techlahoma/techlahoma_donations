source 'https://rubygems.org'
ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.8'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
#

gem 'techlahoma_auth'


#social
gem "slack-notifier", :require => false


# monitoring
gem 'newrelic_rpm'

# For deploying to heroku
group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

# For the money.
gem 'stripe', '~> 1.31.0'
gem 'stripe_event' # for listening to Stripe webhooks

#exceptions
gem 'rollbar'

gem 'unicorn', '~> 4.8.3'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


group :development, :test do
  gem 'quiet_assets'
  gem 'spring'
  gem 'thin'

  gem 'stripe-ruby-mock', '~> 2.2.1', :require => 'stripe_mock'
  gem 'mocha'

  gem 'dotenv-rails'
  gem 'foreman' # for the procfile
  gem 'forward' # for exposing localhost to get Stripe webhooks

  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'webmock'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
