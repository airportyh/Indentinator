#! /usr/bin/env ruby
require 'getopt/std'
require 'indentinator.rb'
opts = Getopt::Std.getopts('c:vV')
@to_amount = opts['c']
@very_verbose = opts['V']
@verbose = opts['v'] or @very_verbose
@files = ARGV
if @files.size == 0
  puts "Usage: indent-amount <file>"
  exit(0)
end

@files.each do |path|
  File.open(path) do |file|
    lines = file.readlines
    amount = indent_amount(lines)
    
    if @to_amount.nil?
      if amount.nil?
        puts "Failed for #{path}. Is it binary?"
      elsif amount == 0
        puts "#{path} has no indentation."
      else
        puts "#{path} uses #{amount} spaces."
      end
    else
      puts convert_lines(lines, amount, @to_amount).join("\n")
    end
  end
end