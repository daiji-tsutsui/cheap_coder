# frozen_string_literal: true

require 'cheap_coder'
require 'dotenv/load'
require 'parser/current'

CODEPATH = 'samples/test1.rb'

puts '--- ▼ RAW CODE -----------------------------'
code = File.read(CODEPATH)
puts code

puts '--- ▼ PARSE RESULT -------------------------'
expr = Parser::CurrentRuby.parse(code)
puts expr

puts '--- ▼ CENSORED -----------------------------'
method_whitelist = %i[puts]
censor = CheapCoder::Censor.new(
  allowed_methods: method_whitelist,
  evaluator: CheapCoder::AbcEvaluator.new
)
expr = censor.process(expr)
puts Unparser.unparse(expr)

puts '--- ▼ EVALUATE ABC SIZE --------------------'
puts censor.score
