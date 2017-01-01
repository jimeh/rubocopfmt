require 'rubocop'

require 'rubocopfmt/options_parser'
require 'rubocopfmt/formatter'

module RuboCopFMT
  class CLI
    DISABLED_COPS = [
      'Lint/Debugger',
      'Lint/UnusedMethodArgument',
      'Lint/UnusedBlockArgument'
    ].freeze

    def run(args = ARGV)
      @options = OptionsParser.parse(args)

      if @options.files.empty?
        execute_runner
      else
        @options.files.each do |file|
          execute_runner(file)
        end
      end

      0
    end

    private

    def execute_runner(path = nil)
      use_stdin = path.nil?
      args = rubocop_args(use_stdin)

      options, paths = RuboCop::Options.new.parse(args)
      config_store = RuboCop::ConfigStore.new

      options[:stdin] = IO.binread(path) if path

      Rainbow.enabled = false
      config_store.options_config = options[:config] if options[:config]
      config_store.force_default_config! if options[:force_default_config]

      runner = RuboCop::Runner.new(options, config_store)
      trap_interrupt(runner)
      runner.run(paths)
      print options[:stdin]
    end

    def rubocop_args(stdin = true)
      args = [
        '--auto-correct',
        '--cache', 'false',
        '--format', 'RuboCopFMT::Formatter',
        '--except', DISABLED_COPS.join(',')
      ]

      args << '--stdin' if stdin
      args << 'fake.rb'
      args
    end

    def trap_interrupt(runner)
      Signal.trap('INT') do
        exit!(1) if runner.aborting?
        runner.abort
        $stderr.puts
        $stderr.puts 'Exiting... Interrupt again to exit immediately.'
      end
    end
  end
end
