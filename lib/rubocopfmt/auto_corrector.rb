require 'rubocopfmt/options_parser'
require 'rubocopfmt/formatter'

module RuboCopFMT
  class AutoCorrector
    DISABLED_COPS = [
      'Lint/Debugger',
      'Lint/UnusedMethodArgument',
      'Lint/UnusedBlockArgument'
    ].freeze

    RUBOCOP_ARGV = [
      '--auto-correct',
      '--cache', 'false',
      '--format', 'RuboCopFMT::Formatter',
      '--except', DISABLED_COPS.join(',')
    ].freeze

    attr_reader :source
    attr_reader :runner

    def initialize(source, path = nil)
      @source = source
      @path = path
    end

    def correct
      Rainbow.enabled = false
      @runner = RuboCop::Runner.new(options, config_store)
      @runner.run(paths)
      options[:stdin]
    end

    private

    def config_store
      return @config_store if @config_store

      @config_store = RuboCop::ConfigStore.new
      @config_store.options_config = options[:config] if options[:config]
      @config_store.force_default_config! if options[:force_default_config]
      @config_store
    end

    def options
      return @options if @options

      set_options_and_paths
      @options
    end

    def paths
      return @paths if @paths

      set_options_and_paths
      @paths
    end

    def set_options_and_paths
      argv = RUBOCOP_ARGV + [@path || 'fake.rb']
      @options, @paths = RuboCop::Options.new.parse(argv)
      @options[:stdin] = source

      [@options, @paths]
    end
  end
end
