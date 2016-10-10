require File.join(File.dirname(__FILE__), 'lib/wen.rb')
Wen.stash_defaults
Wen::Clock::Tricks.boot_up if IS_PI
run Wen::App
