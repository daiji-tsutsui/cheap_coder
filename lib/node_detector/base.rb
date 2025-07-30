# frozen_string_literal: true

require 'unparser'

module NodeDetector
  class Base
    attr_reader :score

    def initialize
      @score = 0
    end

    def print_debug(node)
      puts Unparser.unparse(node)
    end
  end
end
