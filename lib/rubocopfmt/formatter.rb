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
      sources = []
      sources << new_source_from_str(options.input) if options.input
      sources += options.paths.map { |path| new_source_from_file(path) }
      sources.map { |s| s.auto_correct(options.interactive) }

      @sources = sources
    end

    def options
      @options ||= Options.new
    end

    private

    def new_source_from_str(str)
      Source.new(str, options.src_file)
    end

    def new_source_from_file(path)
      raise FileNotFound, "File not found: #{path}" unless File.exist?(path)

      input = File.read(path, mode: 'rb')
      Source.new(input, path, options.src_file)
    end
  end
end
