# frozen_string_literal: true

module CheapCoder
  class Authorizer
    include AST::Processor::Mixin

    def initialize(allowed_methods)
      @allowed_methods = allowed_methods || []
    end

    def allow?(node)
      raise ArgumentError, "not SEND node: #{node}" unless node.type == :send

      receiver, method = node.to_a
      return false unless receiver.nil?

      @allowed_methods.include?(method)
    end

    def on_def(node)
      print_debug('DEF', node)
      @allowed_methods.push(node.to_a[0])
      default_handler(node)
    end

    def handler_missing(node)
      default_handler(node)
    end

    private

    def default_handler(node)
      node.children.each do |child|
        next child unless child.is_a?(AST::Node)

        process(child)
      end
    end

    def print_debug(msg, node)
      return unless ENV['DEBUG'] == 'true'

      puts "[#{msg}] #{Unparser.unparse(node)}"
    end
  end
end
