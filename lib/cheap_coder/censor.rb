# frozen_string_literal: true

module CheapCoder
  class Censor
    include AST::Processor::Mixin

    def initialize
      @allowed_methods = %i[puts]
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
      type = node.type
      children = node.children.map do |child|
        next child unless child.is_a?(AST::Node)

        process(child)
      end
      Parser::AST::Node.new(type, children)
    end

    private

    def send_allowed?(node)
      return false unless node.to_a[0].nil?

      @allowed_methods.include?(node.to_a[1])
    end

    def print_debug(msg, node)
      return unless ENV['DEBUG'] == 'true'

      puts "[#{msg}] #{Unparser.unparse(node)}"
    end
  end
end
