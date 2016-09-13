# States -- Steinwies -- 03.12.2002 -- benfay@ywesee.com

Dir.entries(File.dirname(__FILE__)).each { |file|
  require('state/' << file) if file =~ /\A[a-z_]+\.rb\z/
}
