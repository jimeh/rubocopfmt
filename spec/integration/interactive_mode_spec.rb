require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Interactive mode skips certain cops to avoid confusion' do
  ['--interactive', '-i'].each do |flag|
    it "does not run Lint/Debugger cop when given #{flag} flag" do
      input = get_fixture(:lint_debugger_input)
      output = get_fixture(:lint_debugger_interactive_output)

      out, s = Open3.capture2("#{fmt_bin} #{flag}", stdin_data: input)

      expect(out).to eq(output)
      expect(s.exitstatus).to eq(0)
    end

    it "does not run Lint/UnusedMethodArgument cop when given #{flag} flag" do
      input = get_fixture(:lint_unused_method_argument_input)
      output = get_fixture(:lint_unused_method_argument_interactive_output)

      out, s = Open3.capture2("#{fmt_bin} #{flag}", stdin_data: input)

      expect(out).to eq(output)
      expect(s.exitstatus).to eq(0)
    end

    it "does not run Lint/UnusedBlockArgument cop when given #{flag} flag" do
      input = get_fixture(:lint_unused_block_argument_input)
      output = get_fixture(:lint_unused_block_argument_interactive_output)

      out, s = Open3.capture2("#{fmt_bin} #{flag}", stdin_data: input)

      expect(out).to eq(output)
      expect(s.exitstatus).to eq(0)
    end

    if rubocop_version?('>= 0.46.0') # rubocop:disable Style/Next
      it "does not run Style/EmptyMethod cop when given #{flag} flag" do
        input = get_fixture(:style_empty_method_input)
        output = get_fixture(:style_empty_method_interactive_output)

        out, s = Open3.capture2("#{fmt_bin} #{flag}", stdin_data: input)

        expect(out).to eq(output)
        expect(s.exitstatus).to eq(0)
      end
    end
  end

  it 'runs Lint/Debugger cop when not given --interactive / -i flag' do
    input = get_fixture(:lint_debugger_input)
    output = get_fixture(:lint_debugger_output)

    out, s = Open3.capture2(fmt_bin, stdin_data: input)

    expect(out).to eq(output)
    expect(s.exitstatus).to eq(0)
  end

  it 'runs Lint/UnusedMethodArgument cop when not given --interactive / -i flag' do
    input = get_fixture(:lint_unused_method_argument_input)
    output = get_fixture(:lint_unused_method_argument_output)

    out, s = Open3.capture2(fmt_bin, stdin_data: input)

    expect(out).to eq(output)
    expect(s.exitstatus).to eq(0)
  end

  it 'runs Lint/UnusedBlockArgument cop when not given --interactive / -i flag' do
    input = get_fixture(:lint_unused_block_argument_input)
    output = get_fixture(:lint_unused_block_argument_output)

    out, s = Open3.capture2(fmt_bin, stdin_data: input)

    expect(out).to eq(output)
    expect(s.exitstatus).to eq(0)
  end

  if rubocop_version?('>= 0.46.0')
    it 'runs Style/EmptyMethod cop when not given --interactive / -i flag' do
      input = get_fixture(:style_empty_method_input)
      output = get_fixture(:style_empty_method_output)

      out, s = Open3.capture2(fmt_bin, stdin_data: input)

      expect(out).to eq(output)
      expect(s.exitstatus).to eq(0)
    end
  end
end
