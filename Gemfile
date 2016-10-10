source 'https://rubygems.org'

# gem 'sbsm', '~> 1.3.0'
gem 'sbsm', :path => '/home/niklaus/git/sbsm'
gem 'htmlgrid', :path => '/home/niklaus/git/htmlgrid'

# gem 'htmlgrid', '~> 1.1.3'
gem 'rclconf',  '1.0.0'
gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"

group :test do
  gem 'minitest', '~> 5.9'
  gem 'watir',    '~> 5.0.0'
end

group :development, :test do
  gem 'rake', '~> 11.2'
  gem 'pry-byebug'
end
