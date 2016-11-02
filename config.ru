require File.join(File.dirname(__FILE__), 'lib/wen.rb')

if $is_pi
  log_path = '/var/log/wen/access.log'
  log = File.new log_path, 'a+'
  $stdout.reopen(log)
  $stderr.reopen(log)
end

Wen.stash_defaults gently: true
Wen::Clock::Tricks.super_wipe if $is_pi
run Wen::App
