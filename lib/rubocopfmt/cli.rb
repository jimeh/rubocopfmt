require 'rubocopfmt/diff'
require 'rubocopfmt/errors'
require 'rubocopfmt/cli_options'
require 'rubocopfmt/formatter'

module RuboCopFMT
  class CLI
    def self.run(args = ARGV)
      new(args).run
    end

    attr_reader :options
    attr_reader :sources

    def initialize(args)
      @options = CLIOptions.parse(args)
    end

    def run
      @sources = format_sources

      if options.list
        print_corrected_list
      elsif options.diff
        print_diff_of_corrections
      elsif options.write
        write_corrected_source
      else
        print_corrected_source
      end

      0
    end

    private

    def format_sources
      formatter = Formatter.new(options)
      formatter.run
      formatter.sources
    end

    def print_corrected_list
      sources.each do |source|
        puts source.path if source.corrected?
      end
    end

    def print_diff_of_corrections
      sources.each do |source|
        next unless source.corrected?

        if source.path && sources.size > 1
          puts "diff #{source.path} rubocopfmt/#{source.path}"
        end
        puts Diff.render(source, options.diff_format)
      end
    end

    def write_corrected_source
      sources.each do |source|
        File.write(source.path, source.output) if source.corrected?
      end
    end

    def print_corrected_source
      sources.each do |source|
        print source.output
      end
    end
  end
end
