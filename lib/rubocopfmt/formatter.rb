require 'rubocopfmt/errors'
require 'rubocopfmt/options'
require 'rubocopfmt/source'

module RuboCopFMT
  class Formatter
    attr_reader :sources

    def initialize(opts = {})
      opts.each do |k, v|
        options.send("#{k}=", v) if options.respond_to?("#{k}=")
      end
    end

    def run
      sources = build_sources
      sources.map(&:auto_correct)

      @sources = sources
    end

    def options
      @options ||= Options.new
    end

    private

    def build_sources
      if options.paths.empty?
        [new_source_from_stdin]
      else
        options.paths.map do |path|
          new_source_from_file(path)
        end
      end
    end

    def new_source_from_stdin
      Source.new($stdin.binmode.read, nil, options.src_dir)
    end

    def new_source_from_file(path)
      raise FileNotFound, "File not found: #{path}" unless File.exist?(path)

      source = File.read(path, mode: 'rb')
      Source.new(source, path, options.src_dir)
    end
  end
end
