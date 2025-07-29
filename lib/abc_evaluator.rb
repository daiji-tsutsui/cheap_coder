# frozen_string_literal: true

require 'parser/current'
require 'unparser'

class AbcEvaluator
  include AST::Processor::Mixin

  attr_reader :score_a

  def initialize
    @score_a = 0
  end

  def handler_missing(node)
    if assignment?(node)
      @score_a += 1
      puts Unparser.unparse(node)
    end

    node.children.each do |child|
      next unless child.is_a?(AST::Node)

      process(child)
    end
  end

  def assignment?(node)
    node.type.to_s.end_with?('asgn')
  end
end
