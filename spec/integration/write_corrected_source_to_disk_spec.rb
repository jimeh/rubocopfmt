require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Write corrected source to disk' do
  it 'writes corrected source back to original files when passed -w flag' do
    input1_file = get_fixture_file(:basic1_input)
    output1 = get_fixture(:basic1_output)
    input2_file = get_fixture_file(:basic2_input)
    output2 = get_fixture(:basic2_output)

    begin
      out, s = Open3.capture2(
        "#{fmt_bin} -w \"#{input1_file.path}\" \"#{input2_file.path}\""
      )

      expect(s.exitstatus).to eq(0)
      expect(out).to eq('')
      expect(File.read(input1_file.path, mode: 'rb')).to eq(output1)
      expect(File.read(input2_file.path, mode: 'rb')).to eq(output2)
    ensure
      input1_file.unlink
      input2_file.unlink
    end
  end

  it 'writes corrected source back to original files when passed --write flag' do
    input1_file = get_fixture_file(:basic1_input)
    output1 = get_fixture(:basic1_output)
    input2_file = get_fixture_file(:basic2_input)
    output2 = get_fixture(:basic2_output)

    begin
      out, s = Open3.capture2(
        "#{fmt_bin} --write \"#{input1_file.path}\" \"#{input2_file.path}\""
      )

      expect(s.exitstatus).to eq(0)
      expect(out).to eq('')
      expect(File.read(input1_file.path, mode: 'rb')).to eq(output1)
      expect(File.read(input2_file.path, mode: 'rb')).to eq(output2)
    ensure
      input1_file.unlink
      input2_file.unlink
    end
  end

  it 'prints error to STDERR and returns 1 when not given any file paths' do
    input1 = get_fixture(:basic1_input)

    out, err, s = Open3.capture3("#{fmt_bin} -w", stdin_data: input1)

    expect(s.exitstatus).to eq(1)
    expect(out).to eq('')
    expect(err)
      .to eq("ERROR: To use --write you must specify one or more files\n")
  end
end
