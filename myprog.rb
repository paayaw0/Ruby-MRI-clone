#!/usr/bin/env ruby

require_relative 'tokenizer'
require_relative 'parser'
require 'byebug'

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
token_stream = []
ln = 0

begin 
  while output = file.readline
    ln += 1
    next if output.match?(/^\n$/)
    token_stream << tokenize(output, ln)
  end
rescue EOFError
  puts ''
  puts 'end of file reached'
end

p token_stream