# frozen_string_literal: true

require 'parser/current'
require_relative 'node_detector'

class AbcEvaluator
  include AST::Processor::Mixin

  def initialize
    @detectors = {
      A: NodeDetector::Assignment.new,
      B: NodeDetector::Branch.new,
      C: NodeDetector::Condition.new,
    }
  end

  def score
    @detectors.transform_values(&:score)
  end

  private

  def handler_missing(node)
    @detectors.each_value { |detector| detector.check(node) }
    node.children.each do |child|
      next unless child.is_a?(AST::Node)

      process(child)
    end
  end
end
