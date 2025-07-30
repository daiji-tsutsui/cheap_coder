# frozen_string_literal: true

require 'parser/current'
require_relative 'node_detector'

class AbcEvaluator
  include AST::Processor::Mixin

  def initialize
    @detector_a = NodeDetector::Assignment.new
  end

  def score_a
    @detector_a.score
  end

  private

  def handler_missing(node)
    @detector_a.check(node)
    node.children.each do |child|
      next unless child.is_a?(AST::Node)

      process(child)
    end
  end
end
