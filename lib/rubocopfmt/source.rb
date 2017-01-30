require 'rubocopfmt/auto_corrector'

module RuboCopFMT
  class Source
    attr_reader :path
    attr_reader :input
    attr_reader :output
    attr_reader :src_dir

    def initialize(input, path = nil, src_dir = nil)
      @input = input
      @path = path
      @src_dir = src_dir
    end

    def auto_correct(interactive = false)
      return unless output.nil?

      @corrector = AutoCorrector.new(input, full_path)
      @output = @corrector.correct(interactive)
    end

    def corrected?
      return @corrected unless @corrected.nil?
      return false if @output.nil?

      @corrected = (@input != @output)
    end

    private

    def full_path
      full_path = path || '__fake__.rb'

      if src_dir.nil?
        full_path
      else
        File.join(src_dir, File.basename(full_path))
      end
    end
  end
end
