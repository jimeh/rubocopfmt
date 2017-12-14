require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Manually specify source directory' do
  let(:input_file) do
    File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/input.rb', __FILE__
    )
  end

  let(:expected_output) do
    path = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/output.rb', __FILE__
    )
    File.read(path, mode: 'rb')
  end

  ['--src-file', '-F'].each do |flag|
    it "respects settings in .rubocop.yml via STDIN and source file specified with #{flag} option" do
      out, s = Open3.capture2(
        "#{fmt_bin} #{flag} \"#{input_file}\"",
        stdin_data: File.read(input_file, mode: 'rb')
      )

      expect(out).to eq(expected_output)
      expect(s.exitstatus).to eq(0)
    end

    it "respects settings in .rubocop.yml via file and source file specified with #{flag} option" do
      tmp = Tempfile.new('uglyruby')
      tmp.write(File.read(input_file, mode: 'rb'))
      tmp.close

      out, s = Open3.capture2(
        "#{fmt_bin} #{flag} \"#{input_file}\" \"#{tmp.path}\""
      )

      expect(out).to eq(expected_output)
      expect(s.exitstatus).to eq(0)
    end
  end
end
