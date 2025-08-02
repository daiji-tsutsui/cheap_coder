# frozen_string_literal: true

require 'parser/current'
require 'unparser'

module CheapCoder
  require_relative 'cheap_coder/version'
  require_relative 'cheap_coder/abc_evaluator'
  require_relative 'cheap_coder/censor'

  module NodeDetector
    require_relative 'cheap_coder/node_detector/base'
    require_relative 'cheap_coder/node_detector/assignment'
    require_relative 'cheap_coder/node_detector/branch'
    require_relative 'cheap_coder/node_detector/condition'
  end
end
