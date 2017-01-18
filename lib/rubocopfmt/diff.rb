require 'diffy'

module RuboCopFMT
  class Diff
    FORMATS = {
      unified: '-U 3',
      rcs: '-n',
      context: '-C 3'
    }.freeze

    DEFAULT_FORMAT = FORMATS[:unified]

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

      out = diff.to_s(:text)
      out << "\n" if rcs?(format)
      out
    end

    private

    def rcs?(format)
      diff_opts(format) == FORMATS[:rcs]
    end

    def diff_opts(format = nil)
      format ? FORMATS[format.downcase.to_sym] : DEFAULT_FORMAT
    end
  end
end
