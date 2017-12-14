require 'spec_helper'

module RuboCopFMT
  RSpec.describe Options do
    describe 'input option' do
      it 'reader/writer methods' do
        options = Options.new

        options.input = 'puts "hello world"'

        expect(options.input).to eq('puts "hello world"')
      end

      it 'defaults to nil' do
        options = Options.new

        expect(options.input).to eq(nil)
      end
    end

    describe 'src_file option' do
      it 'reader/writer methods' do
        options = Options.new

        options.src_file = 'lib/my_awesome/thing.rb'

        expect(options.src_file).to eq('lib/my_awesome/thing.rb')
      end

      it 'defaults to nil' do
        options = Options.new

        expect(options.src_file).to eq(nil)
      end
    end

    describe 'diff_format option' do
      it 'reader/writer methods' do
        options = Options.new

        options.diff_format = 'rcs'

        expect(options.diff_format).to eq('rcs')
      end

      it 'defaults to nil' do
        options = Options.new

        expect(options.diff_format).to eq(nil)
      end
    end

    describe 'paths option' do
      it 'reader/writer methods' do
        options = Options.new

        options.paths = ['foo.rb']

        expect(options.paths).to eq(['foo.rb'])
      end

      it 'defaults to empty Array' do
        options = Options.new

        expect(options.paths).to eq([])
      end
    end

    describe 'diff option' do
      it 'reader/writer methods' do
        options = Options.new

        options.diff = true

        expect(options.diff).to eq(true)
      end

      it 'defaults to false' do
        options = Options.new

        expect(options.diff).to eq(false)
      end
    end

    describe 'list option' do
      it 'reader/writer methods' do
        options = Options.new

        options.list = true

        expect(options.list).to eq(true)
      end

      it 'defaults to false' do
        options = Options.new

        expect(options.list).to eq(false)
      end
    end

    describe 'write option' do
      it 'reader/writer methods' do
        options = Options.new

        options.write = true

        expect(options.write).to eq(true)
      end

      it 'defaults to false' do
        options = Options.new

        expect(options.write).to eq(false)
      end
    end

    describe 'interactive option' do
      it 'reader/interactiver methods' do
        options = Options.new

        options.interactive = true

        expect(options.interactive).to eq(true)
      end

      it 'defaults to false' do
        options = Options.new

        expect(options.interactive).to eq(false)
      end
    end
  end
end
