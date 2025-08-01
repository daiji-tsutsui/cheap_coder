# frozen_string_literal: true

require 'parser/current'
require_relative 'node_detector'

class AbcEvaluator
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

  def check(node)
    @detectors.each_value do |detector|
      detector.check(node)
    end
  end
end
