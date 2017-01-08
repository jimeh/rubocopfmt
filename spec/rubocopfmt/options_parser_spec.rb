require 'spec_helper'

module RuboCopFMT
  RSpec.describe OptionsParser do
    describe '#parse' do
      it 'does not modify input args array' do
        args = ['--diff', 'foo.rb']

        OptionsParser.parse(args)

        expect(args).to eq(['--diff', 'foo.rb'])
      end

      describe 'paths option' do
        describe 'is set based on addtional arguments' do
          it 'when given a single additional argument' do
            args = ['--diff', 'foo.rb']

            options = OptionsParser.parse(args)

            expect(options.paths).to eq(['foo.rb'])
          end

          it 'when given multiple additional arguments' do
            args = ['--diff', 'foo.rb', 'bar.rb', 'Gemfile']

            options = OptionsParser.parse(args)

            expect(options.paths).to eq(['foo.rb', 'bar.rb', 'Gemfile'])
          end
        end
      end

      describe 'diff option' do
        it '--diff' do
          options = Options.new

          OptionsParser.parse(['--diff'], options)

          expect(options.diff).to eq(true)
        end

        it '-d' do
          options = Options.new

          OptionsParser.parse(['-d'], options)

          expect(options.diff).to eq(true)
        end
      end

      describe 'diff_format option' do
        it '--diff-format' do
          options = Options.new

          OptionsParser.parse(['--diff-format', 'rcs'], options)

          expect(options.diff).to eq(true)
          expect(options.diff_format).to eq('rcs')
        end

        it '-D' do
          options = Options.new

          OptionsParser.parse(['-D', 'rcs'], options)

          expect(options.diff).to eq(true)
          expect(options.diff_format).to eq('rcs')
        end
      end

      describe 'list option' do
        it '--list' do
          options = Options.new

          OptionsParser.parse(['--list'], options)

          expect(options.list).to eq(true)
        end

        it '-l' do
          options = Options.new

          OptionsParser.parse(['-l'], options)

          expect(options.list).to eq(true)
        end
      end

      describe 'write option' do
        it '--write' do
          options = Options.new

          OptionsParser.parse(['--write'], options)

          expect(options.write).to eq(true)
        end

        it '-w' do
          options = Options.new

          OptionsParser.parse(['-w'], options)

          expect(options.write).to eq(true)
        end
      end

      describe 'stdin_file option' do
        it '--stdin-file' do
          options = Options.new

          OptionsParser.parse(['--stdin-file', 'foo.rb'], options)

          expect(options.stdin_file).to eq('foo.rb')
        end

        it '-F' do
          options = Options.new

          OptionsParser.parse(['-F', 'foo.rb'], options)

          expect(options.stdin_file).to eq('foo.rb')
        end
      end
    end
  end
end
