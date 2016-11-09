source 'https://rubygems.org'

if File.directory?('../sbsm')
  # gem 'sbsm', :path => '../sbsm/test_old'
  gem 'sbsm', :path => '../sbsm'
else
  gem 'sbsm', :git => 'https://github.com/ngiger/sbsm.git', :branch => 'rack'
end

if File.directory?('../htmlgrid')
  gem 'htmlgrid', :path => '../htmlgrid'
else
  gem 'htmlgrid', '>= 1.1.3'
end

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
