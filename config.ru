require File.join(File.dirname(__FILE__), 'lib/wen.rb')
Wen.stash_colours
Wen::Clock::Tricks.boot_up if RUBY_PLATFORM =~ /arm.*-linux/
run Wen::App
