require 'spec_helper'

module RuboCopFMT
  RSpec.describe Options do
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

    describe 'src_dir option' do
      it 'reader/writer methods' do
        options = Options.new

        options.src_dir = 'lib/my_awesome_thing'

        expect(options.src_dir).to eq('lib/my_awesome_thing')
      end

      it 'defaults to nil' do
        options = Options.new

        expect(options.src_dir).to eq(nil)
      end
    end
  end
end
