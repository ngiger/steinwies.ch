src = File.expand_path('../src', __FILE__)
$: << src unless $:.include?(src)

config = File.expand_path('../etc/config.yml', __FILE__)
if !File.exist?(config)
  FileUtils.makedirs(File.dirname(config), :verbose => TRUE)
  FileUtils.cp(config + '.sample', config, :verbose => TRUE)
end


require 'rake/testtask'
require 'rake/clean'

task :default => :test

dir = File.dirname(__FILE__)
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = Dir.glob("#{dir}/test/**/*_test.rb")
  t.warning = false
  t.verbose = false
end
