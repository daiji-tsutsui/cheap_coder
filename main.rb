# frozen_string_literal: true

require 'dotenv/load'
require './lib/abc_evaluator'
require './lib/censor'
require './lib/my_processor'

CODEPATH = 'samples/test2.rb'

puts '--- ▼ RAW CODE -----------------------------'
code = File.read(CODEPATH)
puts code

puts '--- ▼ PARSE RESULT -------------------------'
expr = Parser::CurrentRuby.parse(code)
puts expr

puts '--- ▼ test -------------------------'
processor = MyProcessor.new(
  evaluator: AbcEvaluator.new,
  censor: Censor.new
)
processor.process(expr)
puts processor.score
