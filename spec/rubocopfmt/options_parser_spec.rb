require 'spec_helper'

module RuboCopFMT
  RSpec.describe OptionsParser do
    describe '#parse' do
      it 'does not modify input args array' do
        args = ['--diff', '-l', 'foo.rb']

        OptionsParser.parse(args)

        expect(args).to eq(['--diff', '-l', 'foo.rb'])
      end

      describe 'paths option' do
        describe 'is set based on addtional arguments' do
          it 'when given a single additional argument' do
            args = ['--diff', '-l', 'foo.rb']

            options = OptionsParser.parse(args)

            expect(options.paths).to eq(['foo.rb'])
          end

          it 'when given multiple additional arguments' do
            args = ['--diff', '-l', 'foo.rb', 'bar.rb', 'Gemfile']

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
    end
  end
end
