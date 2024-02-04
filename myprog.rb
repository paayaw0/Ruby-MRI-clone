#!/usr/bin/env ruby

require_relative 'tokenizer'
require_relative 'parser'

puts "#{ARGV}"


if ARGV.empty?
  puts 'Missing filename (./myprog --help for help)'
  return
end

help_mesasge = <<USAGE
Usage: myprog [filename]
  eg, myprog myprogram.rb
USAGE

if ARGV[0] == '--help'
  puts help_mesasge
  return
end


filename = ARGV[0]

file = File.new filename

begin 
  while output = file.readline
    puts output
    # do sthg with code
  end
rescue EOFError
  puts ''
  puts 'end of file reached'
end