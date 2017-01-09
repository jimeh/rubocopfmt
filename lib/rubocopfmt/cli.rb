require 'rubocopfmt/diff'
require 'rubocopfmt/errors'
require 'rubocopfmt/options_parser'
require 'rubocopfmt/source'

module RuboCopFMT
  class CLI
    def self.run(args = ARGV)
      new(args).run
    end

    attr_reader :options

    def initialize(args)
      @options = OptionsParser.parse(args)
    end

    def run
      if @options.list
        print_corrected_list
      elsif @options.diff
        print_diff_of_corrections
      elsif @options.write
        write_corrected_source
      else
        print_corrected_source
      end

      0
    end

    private

    def require_real_files(flag)
      return unless @options.paths.empty?

      $stderr.puts "ERROR: To use #{flag} you must specify one or more files"
      exit 1
    end

    def print_corrected_list
      require_real_files('--list')

      for_corrected_source do |source|
        puts source.path
      end
    end

    def print_diff_of_corrections
      for_corrected_source do |source|
        if source.path && sources.size > 1
          puts "diff #{source.path} rubocopfmt/#{source.path}"
        end
        puts diff_source(source)
      end
    end

    def write_corrected_source
      require_real_files('--write')

      for_corrected_source do |source|
        File.write(source.path, source.output)
      end
    end

    def print_corrected_source
      for_corrected_source(skip_unchanged: false) do |source|
        print source.output
      end
    end

    def sources
      return @sources if @sources

      if options.paths.empty?
        @sources = [new_source_from_stdin(options.stdin_file)]
      else
        @sources = options.paths.map do |path|
          new_source_from_file(path)
        end
      end
    end

    def for_corrected_source(skip_unchanged: true)
      sources.each do |source|
        source.auto_correct
        next if skip_unchanged && !source.corrected?

        yield(source)
      end
    end

    def diff_source(source)
      diff = Diff.new(source)
      diff.render(options.diff_format)
    end

    def new_source_from_stdin(path = nil)
      Source.new($stdin.binmode.read, path)
    end

    def new_source_from_file(path)
      raise FileNotFound, "File not found: #{path}" unless File.exist?(path)

      source = File.read(path, mode: 'rb')
      Source.new(source, path)
    end
  end
end
