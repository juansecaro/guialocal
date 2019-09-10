source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1', '>= 5.1.6.1'
gem 'webpacker', '~> 4.0', '>= 4.0.7'
# Use postgreSQL as the database for Active Record
gem 'pg', '< 1.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'awesome_print', '~> 1.7', :require => 'ap'
gem 'carrierwave', '~> 1.2', '>= 1.2.3'
gem 'mini_magick', '~> 4.7' #carrierwave dependent
#gem 'searchkick', '~> 3.1'
gem 'friendly_id', '~> 5.2', '>= 5.2.1'
gem 'font_awesome5_rails', '~> 0.3.4'
gem 'simple_form', '~> 3.5'
gem 'bootstrap', '~> 4.3', '>= 4.3.1'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'devise-i18n-views'
gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'
gem 'better_errors', '~> 2.4'
gem 'binding_of_caller', '~> 0.7.3'
gem 'stripe'
gem 'trix'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
gem 'will_paginate-bootstrap4', '~> 0.2.2'
gem 'mail_form'
gem 'meta-tags'
gem 'sidekiq', '~> 5.2', '>= 5.2.3'
gem 'sitemap_generator', '~> 6.0', '>= 6.0.1'
gem "letter_opener", :group => :development
gem 'invisible_captcha', '~> 0.12.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-yarn'
#gem 'capistrano-nvm', require: false
gem 'fog-aws', '~> 3.5', '>= 3.5.2'
gem 'whenever', :require => false



# Add this if you're using rvm
gem 'capistrano-rvm'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
