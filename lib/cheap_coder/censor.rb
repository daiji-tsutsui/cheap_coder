# frozen_string_literal: true

module CheapCoder
  class Censor
    include AST::Processor::Mixin

    def initialize(**option)
      @authorizer = Authorizer.new
      @evaluator = option[:evaluator]
    end

    def score
      @evaluator.score
    end

    def process(expr)
      @authorizer.process(expr)
      super
    end

    def on_xstr(node)
      print_debug('!XSTR', node)
      node.to_a[0]
    end

    def on_send(node)
      return node if send_allowed?(node)

      print_debug('!SEND', node)
      Parser::AST::Node.new(:nil, [])
    end

    def handler_missing(node)
      default_handler(node)
    end

    private

    def default_handler(node)
      @evaluator.check(node) if @evaluator

      type = node.type
      children = node.children.map do |child|
        next child unless child.is_a?(AST::Node)

        process(child)
      end
      Parser::AST::Node.new(type, children)
    end

    def send_allowed?(node)
      return false unless node.to_a[0].nil?

      @authorizer.allow?(node.to_a[1])
    end

    def print_debug(msg, node)
      return unless ENV['CHEAP_CODER_LOGGER_VERBOSE'] == 'true'

      puts "[#{msg}] #{Unparser.unparse(node)}"
    end
  end
end
