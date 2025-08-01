# frozen_string_literal: true

require 'dotenv/load'
require './lib/my_processor'

CODEPATH = 'samples/test1.rb'

puts '--- ▼ RAW CODE -----------------------------'
code = File.read(CODEPATH)
puts code

puts '--- ▼ PARSE RESULT -------------------------'
expr = Parser::CurrentRuby.parse(code)
puts expr

puts '--- ▼ test -------------------------'
processor = MyProcessor.new(
  evaluator: AbcEvaluator.new
)
processor.process(expr)
puts processor.score
