source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "fog"
gem "bcrypt"
gem "faker"
gem "carrierwave"
gem "mini_magick"
gem "bootstrap-sass", "3.3.7"
gem "jquery-turbolinks"
gem "jquery"
gem "jquery-rails"
gem "pry-byebug"
gem "simple_form"
gem "kaminari"
gem "figaro"
gem "ransack"
gem "public_activity"
gem "jquery-validation-rails"
gem "paranoia"
gem "devise"
gem "i18n-js"
gem "font-awesome-rails"
gem "config"
gem "rails-i18n"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "pry-rails"
  gem "pry"
end

group :development do
  gem "mysql2", ">= 0.3.18", "< 0.5"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
