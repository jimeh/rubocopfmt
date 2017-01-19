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

      diff.diff
    end

    private

    def diff_opts(format = nil)
      format ? FORMATS[format.downcase.to_sym] : DEFAULT_FORMAT
    end
  end
end
