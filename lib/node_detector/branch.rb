# frozen_string_literal: true

require_relative 'base'

module NodeDetector
  class Branch < Base
    BRANCH_NODES = %i[send csend yield].freeze

    def check(node)
      @score += 1 if branch?(node)
    end

    private

    def branch?(node)
      BRANCH_NODES.include?(node.type)
    end
  end
end
