# frozen_string_literal: true

require './lib/abc_evaluator'

CODEPATH = 'samples/test1.rb'

puts '--- ▼ RAW CODE -----------------------------'
code = File.read(CODEPATH)
puts code

puts '--- ▼ PARSE RESULT -------------------------'
expr = Parser::CurrentRuby.parse(code)
puts expr

puts '--- ▼ test -------------------------'
evaluator = AbcEvaluator.new
evaluator.process(expr)
puts evaluator.score_a
