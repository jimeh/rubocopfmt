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

    def auto_correct_candidates
      candidates.map(&:auto_correct)
    end

    def require_real_files(flag)
      return unless @options.files.empty?

      $stderr.puts "ERROR: To use #{flag} you must specify one or more files"
      exit 1
    end

    def print_corrected_list
      require_real_files('--list')
      auto_correct_candidates

      candidates.each { |c| puts c.path if c.corrected? }
    end

    def write_corrected_source
      require_real_files('--write')
      auto_correct_candidates

      candidates.each do |candidate|
        File.write(candidate.path, candidate.output) if candidate.corrected?
      end
    end

    def print_corrected_source
      auto_correct_candidates

      candidates.each { |candidate| print candidate.output }
    end

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
