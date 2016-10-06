require File.join(File.dirname(__FILE__), 'lib/wen.rb')
Wen.stash_colours
Wen::Clock::Tricks.boot_up if IS_PI
run Wen::App
