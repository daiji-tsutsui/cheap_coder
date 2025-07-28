# frozen_string_literal: true

require 'parser/current'

code = <<~'CODE'
  def main
    test_print(name)
  end

  def name
    'Adam'
  end

  def test_print(name)
    puts "Hello, #{name}!!"
  end
CODE
puts code

puts Parser::CurrentRuby.parse(code)
