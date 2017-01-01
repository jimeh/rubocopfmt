require 'rubocop'

require 'rubocopfmt/canidate'
require 'rubocopfmt/errors'

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
      candidates.map(&:auto_correct)
      candidates.each do |candidate|
        print candidate.output
      end

      0
    end

    private

    def candidates
      return @candidates if @candidates

      if options.files.empty?
        @candidates = [new_candidate_from_stdin]
      else
        @candidates = options.files.map do |path|
          new_candidate_from_file(path)
        end
      end
    end

    def new_candidate_from_stdin
      Candidate.new($stdin.binmode.read)
    end

    def new_candidate_from_file(path)
      raise FileNotFound, "File not found: #{path}" unless File.exist?(path)

      source = File.read(path, mode: 'rb')
      Candidate.new(source, path)
    end
  end
end
