require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Output to STDOUT' do
  it 'reads from STDIN, prints corrected source to STDOUT' do
    input = get_fixture(:basic1_input)
    output = get_fixture(:basic1_output)

    stdout, status = Open3.capture2(fmt_bin, stdin_data: input)

    expect(status).to eq(0)
    expect(stdout).to eq(output)
  end

  it 'reads from file, prints corrected source to STDOUT' do
    input_file = get_fixture_file(:basic1_input)
    output = get_fixture(:basic1_output)

    begin
      stdout, status = Open3.capture2("#{fmt_bin} \"#{input_file.path}\"")

      expect(status).to eq(0)
      expect(stdout).to eq(output)
    ensure
      input_file.unlink
    end
  end

  it 'reads from multiple files, prints corrected source to STDOUT for all' do
    input1_file = get_fixture_file(:basic1_input)
    output1 = get_fixture(:basic1_output)
    input2_file = get_fixture_file(:basic2_input)
    output2 = get_fixture(:basic2_output)

    begin
      stdout, status = Open3.capture2(
        "#{fmt_bin} \"#{input1_file.path}\" \"#{input2_file.path}\""
      )

      expect(status).to eq(0)
      expect(stdout).to eq(output1 + output2)
    ensure
      input1_file.unlink
      input2_file.unlink
    end
  end
end
