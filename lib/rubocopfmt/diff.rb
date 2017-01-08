require 'diffy'

module RuboCopFMT
  class Diff
    FORMATS = {
      unified: '-U 3',
      rcs: '-n',
      context: '-C 3'
    }.freeze

    DEFAULT_FORMAT = :unified

    attr_reader :source

    def self.valid_format?(format)
      FORMATS.key?(format.downcase.to_sym)
    end

    def initialize(source)
      @source = source
    end

    def render(format = nil)
      diff = Diffy::Diff.new(
        source.input, source.output,
        include_diff_info: true,
        diff: diff_opts(format)
      )

      diff.to_s(:text)
    end

    private

    def diff_opts(format = nil)
      return FORMATS[format.downcase.to_sym] if format
      FORMATS[DEFAULT_FORMAT]
    end
  end
end
