require 'rubocopfmt/auto_corrector'

module RuboCopFMT
  class Candidate
    attr_reader :path
    attr_reader :input
    attr_reader :output

    def initialize(input, path = nil)
      @input = input
      @path = path
    end

    def auto_correct
      return unless output.nil?

      @corrector = AutoCorrector.new(input)
      @output = @corrector.correct
    end

    def corrected?
      return false if @corrector.nil?
      !@corrector.warnings.empty? || !@corrector.errors.empty?
    end
  end
end
