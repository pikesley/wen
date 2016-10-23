require File.join(File.dirname(__FILE__), 'lib/wen.rb')

if IS_PI
  log_path = '/var/log/wen/access.log'
  log = File.new log_path, 'a+'
  $stdout.reopen(log)
  $stderr.reopen(log)
end

Wen.stash_defaults
Wen::Clock::Tricks.super_wipe if IS_PI
run Wen::App
