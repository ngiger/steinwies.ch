# Steinwies -- steinwies -- 09.04.2003 -- hwyss@ywesee.com

require 'rclconf'

module Steinwies
  project_root = File.expand_path('../..', File.dirname(__FILE__))
  config_file  = File.join(project_root, 'etc', 'config.yml')
  defaults = {
    'config'     => config_file,
    'server_uri' => 'druby://localhost:10001',
    'log_pattern' => File.join(Dir.pwd, 'log','/%Y/%m/%d/steinwies_log'),
    'server_name' => 'localhost',
    'server_port' => '7777',
    # smtp
    :mailer => {
      :from   => '"Steinwies" <steinwies@example.org>',
      :to     => %w[],
      :server => '',
      :domain => 'example.org',
      :port   => 587,
      :auth   => 'plain',
      :user   => '',
      :pass   => '',
    }
  }

  # NOTE
  # RCLConf returns a hash which holds keys as String
  config = RCLConf::RCLConf.new(ARGV, defaults)
  config.load(config.config)
  @config = config
end
