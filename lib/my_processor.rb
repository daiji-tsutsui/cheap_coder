# frozen_string_literal: true

require './lib/abc_evaluator'

class MyProcessor
  include AST::Processor::Mixin

  def initialize
    @evaluator = AbcEvaluator.new
  end

  def score
    @evaluator.score
  end

  private

  def handler_missing(node)
    @evaluator.check(node)
    node.children.each do |child|
      next unless child.is_a?(AST::Node)

      process(child)
    end
  end
end
