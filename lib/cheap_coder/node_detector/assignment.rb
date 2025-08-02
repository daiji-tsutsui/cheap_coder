# frozen_string_literal: true

module CheapCoder
  module NodeDetector
    class Assignment < Base
      def detected?(node)
        node.type.to_s.end_with?('asgn')
      end
    end
  end
end
