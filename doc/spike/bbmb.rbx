#!/usr/bin/env ruby
# bbmb.rbx

cgi = CGI.new

begin
cgi.out {
	src = "MyModules: \n"
Module.constants.each { |const|
	src <<  const.to_s << "\n"
}
	src
}
rescue Exception =>	e
	cgi.out { e.backtrace }
end
