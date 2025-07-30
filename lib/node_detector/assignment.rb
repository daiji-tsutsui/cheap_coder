# frozen_string_literal: true

require_relative 'base'

module NodeDetector
  class Assignment < Base
    def check(node)
      @score += 1 if assignment?(node)
    end

    private

    def assignment?(node)
      node.type.to_s.end_with?('asgn')
    end
  end
end
