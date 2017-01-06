require 'optparse'
require 'rubocop'

require 'rubocopfmt/options'
require 'rubocopfmt/version'

module RuboCopFMT
  class OptionsParser
    class << self
      def parse(args, options = nil)
        args = args.clone
        options ||= Options.new

        parse_flags(args, options)
        options.files = args unless args.empty?

        options
      end

      private

      def parse_flags(args, options)
        parser = OptionParser.new do |opts|
          opts.program_name = 'rubocopfmt'
          opts.version = RuboCopFMT::VERSION

          opts.banner = 'Usage: rubocopfmt [options] [path ...]'
          opts.separator ''
          opts.separator 'Reads from STDIN if no path is given.'
          opts.separator ''
          opts.separator 'Options:'

          opts.on(
            '-d', '--diff',
            'Display diffs instead of rewriting files.'
          ) { |v| options.diff = v }

          opts.on(
            '-l', '--list',
            'List files whose formatting is incorrect.'
          ) { |v| options.list = v }

          opts.on(
            '-w', '--write',
            'Write result to (source) file instead of STDOUT.'
          ) { |v| options.write = v }

          opts.separator ''

          opts.on('-v', '--version', 'Show version.') do
            puts "#{opts.program_name} #{opts.version}" \
                 " (rubocop #{RuboCop::Version::STRING})"
            exit
          end

          opts.on('-h', '--help', 'Show this message.') do
            puts opts
            exit
          end
        end
        parser.parse!(args)
      end
    end
  end
end
