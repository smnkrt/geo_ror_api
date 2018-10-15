# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 5.2.1'
gem 'sqlite3'

gem 'dry-validation'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'spring'
end
