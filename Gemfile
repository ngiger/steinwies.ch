source 'https://rubygems.org'

gem 'sbsm','>= 1.3.2'
gem 'htmlgrid', '>= 1.1.3'
gem 'mail'

gem 'rclconf',  '1.0.0'
gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"

group :test do
  gem 'nokogiri'
  gem "rack-test", require: "rack/test"
  gem 'minitest'
  gem "watir"
  gem 'foreman'
  gem 'rspec'
  gem 'flexmock'
  gem 'page-object'
end

group :development, :test do
  gem 'rake', '~> 11.2'
  gem 'pry-byebug'
end
