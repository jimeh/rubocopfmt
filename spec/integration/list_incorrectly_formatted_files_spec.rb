require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: List incorrectly formatted files' do
  it 'prints list of incorrectly formatted files when passed -l flag' do
    input1_file = get_fixture_file(:basic1_input)
    output1_file = get_fixture_file(:basic1_output)
    input2_file = get_fixture_file(:basic2_input)
    output2_file = get_fixture_file(:basic2_output)

    begin
      out, s = Open3.capture2(
        "#{fmt_bin} -l" \
        " \"#{input1_file.path}\" \"#{output1_file.path}\"" \
        " \"#{input2_file.path}\" \"#{output2_file.path}\""
      )

      expect(s.exitstatus).to eq(0)
      expect(out).to eq("#{input1_file.path}\n#{input2_file.path}\n")
    ensure
      input1_file.unlink
      output1_file.unlink
      input2_file.unlink
      output2_file.unlink
    end
  end

  it 'prints list of incorrectly formatted files when passed --list flag' do
    input1_file = get_fixture_file(:basic1_input)
    output1_file = get_fixture_file(:basic1_output)
    input2_file = get_fixture_file(:basic2_input)
    output2_file = get_fixture_file(:basic2_output)

    begin
      out, s = Open3.capture2(
        "#{fmt_bin} --list" \
        " \"#{input1_file.path}\" \"#{output1_file.path}\"" \
        " \"#{input2_file.path}\" \"#{output2_file.path}\""
      )

      expect(s.exitstatus).to eq(0)
      expect(out).to eq("#{input1_file.path}\n#{input2_file.path}\n")
    ensure
      input1_file.unlink
      output1_file.unlink
      input2_file.unlink
      output2_file.unlink
    end
  end

  it 'prints error to STDERR and returns 1 when not given any file paths' do
    input1 = get_fixture(:basic1_input)

    out, err, s = Open3.capture3("#{fmt_bin} -l", stdin_data: input1)

    expect(s.exitstatus).to eq(255)
    expect(out).to eq('')
    expect(err).to eq(
      "Error: argument --list requires one or more paths to be specified.\n" \
      "Try --help for help.\n"
    )
  end
end
