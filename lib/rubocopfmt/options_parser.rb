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
          opt :diff_format, 'Display diffs using format: unified, rcs, context',
              short: 'D', type: :string
          banner ''

          conflicts :diff, :list, :write
          conflicts :diff_format, :list, :write
        end

        if opts[:diff_format] && !Diff.valid_format?(opts[:diff_format])
          Trollop.die :diff_format,
                      "does not support \"#{opts[:diff_format]}\" format"
        end

        opts[:diff] = true if opts[:diff_format] && !opts[:diff]

        opts.each do |k, v|
          options.send("#{k}=", v) if options.respond_to?("#{k}=")
        end

        options
      end
    end
  end
end
