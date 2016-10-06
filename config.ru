require File.join(File.dirname(__FILE__), 'lib/wen.rb')
Wen.stash_colours
Wen::Clock.boot_up
run Wen::App
