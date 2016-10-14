require File.join(File.dirname(__FILE__), 'lib/wen.rb')
Wen.stash_defaults
Wen::Clock::Tricks.super_wipe if IS_PI
run Wen::App
