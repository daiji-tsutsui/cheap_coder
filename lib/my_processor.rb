# frozen_string_literal: true

require './lib/abc_evaluator'

class MyProcessor
  include AST::Processor::Mixin

  def initialize(**option)
    @evaluator = option[:evaluator]
  end

  def score
    return unless @evaluator

    @evaluator.score
  end

  private

  def handler_missing(node)
    @evaluator&.check(node)
    node.children.each do |child|
      next unless child.is_a?(AST::Node)

      process(child)
    end
  end
end
