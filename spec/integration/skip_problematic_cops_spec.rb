require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Skip problematic cops' do
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
