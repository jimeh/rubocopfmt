require 'rubocopfmt/auto_corrector'

module RuboCopFMT
  class Source
    attr_reader :path
    attr_reader :input
    attr_reader :output

    def initialize(input, path = nil)
      @input = input
      @path = path
    end

    def auto_correct
      return unless output.nil?

      @corrector = AutoCorrector.new(input, path)
      @output = @corrector.correct
    end

    def corrected?
      return @corrected unless @corrected.nil?
      return false if @output.nil?

      @corrected = (@input != @output)
    end
  end
end
