require 'rubocopfmt/options_parser'
require 'rubocopfmt/formatter'

module RuboCopFMT
  class AutoCorrector
    DISABLED_COPS = [
      'Lint/Debugger',
      'Lint/UnusedMethodArgument',
      'Lint/UnusedBlockArgument'
    ].freeze

    RUBOCOP_OPTS = [
      '--stdin',
      '--auto-correct',
      '--cache', 'false',
      '--format', 'RuboCopFMT::Formatter',
      '--except', DISABLED_COPS.join(','),
      'fake.rb'
    ].freeze

    attr_reader :source
    attr_reader :runner

    def initialize(source)
      @source = source
    end

    def correct
      options, paths = RuboCop::Options.new.parse(RUBOCOP_OPTS)
      config_store = RuboCop::ConfigStore.new

      options[:stdin] = source

      Rainbow.enabled = false
      config_store.options_config = options[:config] if options[:config]
      config_store.force_default_config! if options[:force_default_config]

      @runner = RuboCop::Runner.new(options, config_store)
      @runner.run(paths)
      options[:stdin]
    end

    def warnings
      runner && runner.warnings
    end

    def errors
      runner && runner.errors
    end
  end
end
