require 'rubocop'

module RuboCopFMT
  # Does nothing, as we want nothing output but the corrected source code.
  class RubocopFormatter < ::RuboCop::Formatter::BaseFormatter; end
end
