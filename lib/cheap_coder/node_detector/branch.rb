# frozen_string_literal: true

module CheapCoder
  module NodeDetector
    class Branch < Base
      BRANCH_NODES = %i[send csend yield].freeze
      private_constant :BRANCH_NODES

      def detected?(node)
        BRANCH_NODES.include?(node.type)
      end
    end
  end
end
