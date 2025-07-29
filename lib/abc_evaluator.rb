# frozen_string_literal: true

require 'parser/current'

class AbcEvaluator
  include AST::Processor::Mixin

  def handler_missing(node)
    node.children.each do |child|
      next unless child.is_a?(AST::Node)

      puts child.type
      process(child)
    end
  end
end
