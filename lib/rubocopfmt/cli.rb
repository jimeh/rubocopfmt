require 'rubocop'

require 'rubocopfmt/errors'
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
      elsif @options.write
        write_corrected_source
      else
        print_corrected_source
      end

      0
    end

    private

    def auto_correct_sources
      sources.map(&:auto_correct)
    end

    def require_real_files(flag)
      return unless @options.files.empty?

      $stderr.puts "ERROR: To use #{flag} you must specify one or more files"
      exit 1
    end

    def print_corrected_list
      require_real_files('--list')
      auto_correct_sources

      sources.each { |c| puts c.path if c.corrected? }
    end

    def write_corrected_source
      require_real_files('--write')
      auto_correct_sources

      sources.each do |source|
        File.write(source.path, source.output) if source.corrected?
      end
    end

    def print_corrected_source
      auto_correct_sources

      sources.each { |source| print source.output }
    end

    def sources
      return @sources if @sources

      if options.files.empty?
        @sources = [new_source_from_stdin]
      else
        @sources = options.files.map do |path|
          new_source_from_file(path)
        end
      end
    end

    def new_source_from_stdin
      Source.new($stdin.binmode.read)
    end

    def new_source_from_file(path)
      raise FileNotFound, "File not found: #{path}" unless File.exist?(path)

      source = File.read(path, mode: 'rb')
      Source.new(source, path)
    end
  end
end
