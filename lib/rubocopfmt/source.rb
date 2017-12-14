require 'rubocopfmt/auto_corrector'

module RuboCopFMT
  class Source
    attr_reader :path
    attr_reader :input
    attr_reader :output
    attr_reader :src_path

    def initialize(input, path = nil, src_path = nil)
      @input = input
      @path = path
      @src_path = src_path
    end

    def auto_correct(interactive = false)
      return unless output.nil?

      @corrector = AutoCorrector.new(input, src_path || path)
      @output = @corrector.correct(interactive)
    end

    def corrected?
      return @corrected unless @corrected.nil?
      return false if @output.nil?

      @corrected = (@input != @output)
    end
  end
end
