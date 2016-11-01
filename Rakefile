src = File.expand_path('../src', __FILE__)
$: << src unless $:.include?(src)

config = File.expand_path('../etc/config.yml', __FILE__)
if !File.exist?(config)
  FileUtils.makedirs(File.dirname(config), :verbose => TRUE)
  FileUtils.cp(config + '.sample', config, :verbose => TRUE)
end
 desc "create RDoc documentation"

 task :rdoc do
   cmd = "bundle exec rdoc --exclude='/coverage|vendor|test|data|etc|Manifest|.*.lock|.*.css|.*.js|.*.gemspec/' --include=lib" +
       " --main=niklaus --title=SBSM"
   puts cmd
   res = system(cmd)
   puts "Running test/suite.rb returned #{res.inspect}. Output is found in the doc sub-directory"
   exit 1 unless res
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
