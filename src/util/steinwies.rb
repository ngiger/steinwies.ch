#!/usr/bin/env ruby
# SteinwiesServer

$: << File.expand_path("..", File.dirname(__FILE__))

require 'drb/drb'
require 'util/steinwiesapp'

while arg = ARGV.shift
  case arg
	when ''
		#ignore
  when '--detach'
    $detach = true
  when /^--pidfile=(.+)/
    $pidfile = $1
  else
    STDERR.puts "usage: #$0 [--detach] [--pidfile=PIDFILE] [--env]"
    exit 1
  end
end

if $pidfile
  pidfile = open($pidfile, "w")
end

if $detach
	p "detaching"
  Process.fork and exit!(0)
  Process.setsid
  Process.fork and exit!(0)
  
  trap("INT") { }
end

steinwies = Steinwies::SteinwiesApp.new

if pidfile
  pidfile.puts $$
  pidfile.close
  
  END { File.unlink $pidfile }
end

trap("HUP") { puts "caught HUP signal, shutting down\n"; exit }
trap("ALRM") { puts "caught ALRM signal, clearing Sessions\n"; steinwies.clear }
trap("TERM") { puts "caught TERM signal, exiting immediately\n"; exit }

p "starting drb-service"
DRb.start_service(Steinwies::SERVER_URI, steinwies)

#STDIN.close
#STDOUT.close
#STDERR.close
$0 = "Steinwies (SteinwiesApp)"

DRb.thread.join
