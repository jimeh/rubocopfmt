require 'trollop'
require 'rubocop'

require 'rubocopfmt/core_ext/string'
require 'rubocopfmt/options'
require 'rubocopfmt/version'

module RuboCopFMT
  class OptionsParser
    class << self
      def parse(args, options = nil)
        args = args.clone
        options ||= Options.new

        parse_flags(args, options)
        options.paths = args unless args.empty?

        options
      end

      private

      def parse_flags(args, options)
        opts = Trollop.options(args) do
          banner <<-EOF.undent
            Usage: rubocopfmt [options] [path ...]

            Reads from STDIN if no path is given.

            Options:
          EOF

          version "rubocopfmt #{RuboCopFMT::VERSION}" \
                  " (rubocop #{RuboCop::Version::STRING})"

          opt :diff, 'Display diffs instead of rewriting files.'
          opt :list, 'List files whose formatting is incorrect.'
          opt :write, 'Write result to (source) file instead of STDOUT.'
          opt :stdin_file, 'Optionally provide file path when using STDIN.',
              short: 'F', type: :string
          banner ''

          conflicts :diff, :list, :write
        end

        options.diff = opts[:diff]
        options.list = opts[:list]
        options.write = opts[:write]
        options.stdin_file = opts[:stdin_file]
        options
      end
    end
  end
end
