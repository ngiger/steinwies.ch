#!/usr/bin/env ruby 
# home.rbx -- steinwies -- 19.11.2002 -- benfay@ywesee.com

$: << File.expand_path('../src', File.dirname(__FILE__))
require 'sbsm/request'
require 'util/steinwiesconfig'

=begin
cgi = CGI.new('html4')
cgi.out { 
Module.constants.collect { |const|
		"-->" <<  const
	}.join("<br>")
}
exit
=end

DRb.start_service()
begin
	SBSM::Request.new(Steinwies::SERVER_URI).process
rescue Exception => e
	$stderr << "STEINWIES-Client-Error: " << e.message << "\n"
	$stderr << e.class << "\n"
	$stderr << e.backtrace.join("\n") << "\n"
end
