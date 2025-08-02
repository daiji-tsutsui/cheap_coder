# frozen_string_literal: true

require 'dotenv/load'
require 'unparser'
require './lib/abc_evaluator'
require './lib/censor'

CODEPATH = 'samples/test2.rb'

puts '--- ▼ RAW CODE -----------------------------'
code = File.read(CODEPATH)
puts code

puts '--- ▼ PARSE RESULT -------------------------'
expr = Parser::CurrentRuby.parse(code)
puts expr

puts '--- ▼ CENSORED -----------------------------'
censor = Censor.new
expr = censor.process(expr)
puts Unparser.unparse(expr)

puts '--- ▼ EVALUATE ABC SIZE --------------------'
evaluator = AbcEvaluator.new
evaluator.process(expr)
puts evaluator.score
