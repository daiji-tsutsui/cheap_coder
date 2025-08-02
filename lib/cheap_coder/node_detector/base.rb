# frozen_string_literal: true

module CheapCoder
  module NodeDetector
    class Base
      attr_reader :score

      def initialize
        @score = 0
      end

      def check(node)
        return unless detected?(node)

        print_debug(node)
        @score += 1
      end

      def print_debug(node)
        return unless ENV['CHEAP_CODER_LOGGER_VERBOSE'] == 'true'

        class_type = self.class.name.split('::').last
        puts "[#{class_type}] #{Unparser.unparse(node)}"
      end
    end
  end
end
