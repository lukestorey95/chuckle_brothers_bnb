source "https://rubygems.org"

ruby '3.0.2'

gem 'puma'
gem 'sinatra'
gem 'pg'
gem 'rerun'
gem 'sinatra-flash'
gem 'bcrypt'
gem 'rack_session_access'



group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development, :test do
  gem 'rubocop', '1.20'
end