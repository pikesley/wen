require File.join(File.dirname(__FILE__), 'lib/wen.rb')

log_path = 'log/access.log'
log_path = '/var/log/wen/access.log' if IS_PI
log = File.new log_path, 'a+'
$stdout.reopen(log)
$stderr.reopen(log)

Wen.stash_defaults
Wen::Clock::Tricks.super_wipe if IS_PI
run Wen::App
