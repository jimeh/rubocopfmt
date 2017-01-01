require 'spec_helper'
require 'open3'

RSpec.describe 'Integration' do
  it 'reads from STDIN, prints corrected source to STDOUT' do
    input = get_fixture(:basic_input)
    output = get_fixture(:basic_output)

    stdout, status = Open3.capture2(fmt_bin, stdin_data: input)

    expect(status).to eq(0)
    expect(stdout).to eq(output)
  end

  it 'reads from file, prints corrected source to STDOUT' do
    input_file = get_fixture_file(:basic_input)
    output = get_fixture(:basic_output)

    begin
      stdout, status = Open3.capture2("#{fmt_bin} \"#{input_file.path}\"")

      expect(status).to eq(0)
      expect(stdout).to eq(output)
    ensure
      input_file.unlink
    end
  end

  it 'reads from multiple files, prints corrected source to STDOUT for all' do
    input1_file = get_fixture_file(:basic_input)
    output1 = get_fixture(:basic_output)
    input2_file = get_fixture_file(:skip_lint_debugger_input)
    output2 = get_fixture(:skip_lint_debugger_output)

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

  it 'does not run Lint/Debugger cop' do
    input = get_fixture(:skip_lint_debugger_input)
    output = get_fixture(:skip_lint_debugger_output)

    stdout, status = Open3.capture2(fmt_bin, stdin_data: input)

    expect(stdout).to eq(output)
    expect(status).to eq(0)
  end

  it 'does not run Lint/UnusedMethodArgument cop' do
    input = get_fixture(:skip_lint_unused_method_argument_input)
    output = get_fixture(:skip_lint_unused_method_argument_output)

    stdout, status = Open3.capture2(fmt_bin, stdin_data: input)

    expect(stdout).to eq(output)
    expect(status).to eq(0)
  end

  it 'does not run Lint/UnusedBlockArgument cop' do
    input = get_fixture(:skip_lint_unused_block_argument_input)
    output = get_fixture(:skip_lint_unused_block_argument_output)

    stdout, status = Open3.capture2(fmt_bin, stdin_data: input)

    expect(stdout).to eq(output)
    expect(status).to eq(0)
  end
end
