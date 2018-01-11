source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'mysql2'
gem 'convergence'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'kaminari'
gem 'settingslogic'
gem 'devise'
gem 'ransack'
gem 'oga'
gem 'rest-client'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'active_hash'
gem 'webpacker', '~> 3.0'
gem 'materialize-sass'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'annotate'
  gem 'rubocop'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
