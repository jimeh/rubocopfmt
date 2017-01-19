require 'rubocop'

require 'rubocopfmt/rubocop_formatter'

module RuboCopFMT
  class AutoCorrector
    attr_reader :input
    attr_reader :runner

    def initialize(input, path = nil)
      @input = input
      @path = path
    end

    def correct
      Rainbow.enabled = false if defined?(Rainbow)

      @runner = ::RuboCop::Runner.new(options, config_store)
      @runner.run(paths)

      options[:stdin]
    end

    private

    def paths
      @paths ||= [@path || 'fake.rb']
    end

    def options
      @options ||= {
        stdin: @input,
        auto_correct: true,
        cache: 'false',
        formatters: [['RuboCopFMT::RubocopFormatter']],
        except: disabled_cops
      }
    end

    def disabled_cops
      [
        'Lint/Debugger',
        'Lint/UnusedMethodArgument',
        'Lint/UnusedBlockArgument'
      ]
    end

    def config_store
      return @config_store if @config_store

      @config_store = ::RuboCop::ConfigStore.new
      @config_store.options_config = options[:config] if options[:config]
      @config_store.force_default_config! if options[:force_default_config]
      @config_store
    end
  end
end
