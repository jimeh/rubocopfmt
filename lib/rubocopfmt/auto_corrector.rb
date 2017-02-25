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

    def correct(interactive = false)
      Rainbow.enabled = false if defined?(Rainbow)

      options = default_options.clone
      options[:except] = bad_interactive_cops if interactive

      @runner = ::RuboCop::Runner.new(options, ::RuboCop::ConfigStore.new)
      @runner.run(paths)

      options[:stdin]
    end

    private

    def paths
      @paths ||= [@path || '__fake__.rb']
    end

    def default_options
      {
        stdin: @input,
        auto_correct: true,
        cache: 'false',
        formatters: [['RuboCopFMT::RubocopFormatter']]
      }
    end

    def bad_interactive_cops
      [
        'Lint/Debugger',
        'Lint/UnusedBlockArgument',
        'Lint/UnusedMethodArgument',
        'Style/EmptyMethod'
      ]
    end
  end
end
