require 'optparse'

require 'rubocopfmt/options'

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
          opts.banner = 'Usage: rubocopfmt [options] [path ...]'
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
        end
        parser.parse!(args)
      end
    end
  end
end
