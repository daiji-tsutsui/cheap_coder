# frozen_string_literal: true

require_relative 'base'

module NodeDetector
  class Branch < Base
    BRANCH_NODES = %i[send csend yield].freeze
    private_constant :BRANCH_NODES

    def detected?(node)
      BRANCH_NODES.include?(node.type)
    end
  end
end
