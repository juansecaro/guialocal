source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.7'
gem 'webpacker', '~> 4.2', '>= 4.2.2'
# Use postgreSQL as the database for Active Record
gem 'pg', '< 1.0'
# Use Puma as the app server
gem 'puma', '~> 3.12.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'

gem 'carrierwave', '~> 2.0', '>= 2.0.2'
gem 'mini_magick', '~> 4.7' #carrierwave dependent
gem 'friendly_id', '~> 5.2', '>= 5.2.1'
gem 'font_awesome5_rails', '~> 0.3.6'
gem "simple_form", ">= 5.0.2"
gem 'bootstrap', '~> 4.5', '>= 4.5.0'
gem 'devise', '~> 4.7', '>= 4.7.2'
gem 'devise-i18n-views'
gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'
gem 'stripe'
gem 'trix', '>= 0.11.1'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
gem 'will_paginate-bootstrap4', '~> 0.2.2'
gem 'mail_form', '>= 1.8.0'
gem 'meta-tags', '>= 2.13.0'
gem 'sidekiq', '~> 5.2', '>= 5.2.9'
gem 'sitemap_generator', '~> 6.0', '>= 6.0.1'
gem 'invisible_captcha', '~> 0.12.2'
gem 'wicked', '>= 1.3.4'
# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'capistrano', '~> 3.14', '>= 3.14.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
gem 'capistrano-yarn'
#gem 'capistrano-rvm' # ojo con rbenv
#gem 'capistrano-nvm', require: false
gem 'fog-aws', '~> 3.5', '>= 3.5.2'
gem 'whenever', :require => false



gem 'web-console', '>= 3.7.0', group: :development
group :development, :test do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'minitest-reporters', '~> 1.4', '>= 1.4.2'
  gem 'awesome_print', '~> 1.7', :require => 'ap'
  gem "letter_opener"
  gem 'listen', '~> 3.0.5'
  gem 'better_errors', '~> 2.7', '>= 2.7.1'
  gem "binding_of_caller"
  gem 'rubocop', '~> 0.79.0', require: false
  gem 'byebug', platform: :mri
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
