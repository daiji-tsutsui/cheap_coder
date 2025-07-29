# frozen_string_literal: true

require 'parser/current'

CODEPATH = 'samples/test1.rb'
code = File.read(CODEPATH)
puts '--- ▼ RAW CODE -----------------------------'
puts code

puts '--- ▼ PARSE RESULT -------------------------'
puts Parser::CurrentRuby.parse(code)
