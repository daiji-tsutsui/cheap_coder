# frozen_string_literal: true

require 'unparser'

class Censor
  def initialize
    @allowed_methods = %i(puts)
  end

  def refine!(node)
    if node.type == :xstr
      omit_xstr!(node)
    elsif node.type == :send
      omit_send!(node)
    end
  end

  private

  def omit_xstr!(node)
    print_debug('!XSTR', node)
    # node = node.children.first
  end

  def omit_send!(node)
    return if send_allowed?(node)

    print_debug('!SEND', node)
    # node = nil
  end

  def send_allowed?(node)
    return false unless node.to_a[0].nil?

    @allowed_methods.include?(node.to_a[1])
  end

  def print_debug(msg, node)
    return unless ENV['DEBUG'] == 'true'

    puts "[#{msg}] #{Unparser.unparse(node)}"
  end
end
