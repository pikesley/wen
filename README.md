[![Build Status](http://img.shields.io/travis/pikesley/wen.svg?style=flat-square)](https://travis-ci.org/pikesley/wen)
[![Dependency Status](http://img.shields.io/gemnasium/pikesley/wen.svg?style=flat-square)](https://gemnasium.com/pikesley/wen)
[![Coverage Status](http://img.shields.io/coveralls/pikesley/wen.svg?style=flat-square)](https://coveralls.io/r/pikesley/wen)
[![Code Climate](http://img.shields.io/codeclimate/github/pikesley/wen.svg?style=flat-square)](https://codeclimate.com/github/pikesley/wen)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://pikesley.mit-license.org)

# Wen, the eternally surprised

_A RESTful clock because why not?_

This story begins with a man named [Frank Howarth](). I've spent a _lot_ of time over the last few years, obsessively watching woodturning videos by Frank and others, and then earlier this year I went on a [woodturning course]() (with my friend [Chris]()), where I [used a lathe for the first time](). I came back sufficiently enthused that my girlfriend bought me [a mini-lathe]() for my birthday, and I've spent most weekends since then turning [nightlight holders]() and other things in the garden.

## Everything is a circle

When all you have is a lathe, everything you make is round. It occurred to me that I might be able to fashion a clock, using some [Neopixel rings]() for the dials, and driven by a [Raspberry Pi](). So I turned a simple clock body out of a maple disc, bought some Neopixels and a Pi Zero, and this is what I came up with...

## The hardware

I was given to understand, from reading the specs, that a Pi would not be able to handle the timing requirements of the Neopixels, and I would need an [Arduino]() in between Pi and pixels. However, after a conversation with [Chris]() at a [very weird bar in South London]() I discovered that there are [some pins on a Pi]() that have enough grunt to drive the Neopixels, and that even better, there's a [Ruby Gem]() - no Arduino required.

So I have physical 