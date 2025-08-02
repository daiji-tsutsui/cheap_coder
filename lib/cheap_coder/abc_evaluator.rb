# frozen_string_literal: true

module CheapCoder
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

    def handler_missing(node)
      check(node)
      node.children.each do |child|
        next unless child.is_a?(AST::Node)

        process(child)
      end
    end

    private

    def check(node)
      @detectors.each_value do |detector|
        detector.check(node)
      end
    end
  end
end
