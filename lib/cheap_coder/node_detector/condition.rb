# frozen_string_literal: true

module CheapCoder
  module NodeDetector
    class Condition < Base
      CONDITION_NODES = %i[if while until for csend block block_pass
                           rescue when in_pattern and or or_asgn and_asgn].freeze
      private_constant :CONDITION_NODES

      def detected?(node)
        CONDITION_NODES.include?(node.type)
      end
    end
  end
end
