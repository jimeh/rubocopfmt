require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Help output' do
  let(:expected_help) do
    <<-EOF.undent
      Usage: rubocopfmt [options] [path ...]

      Reads from STDIN if no path is given.

      Options:
        -d, --diff               Display diffs instead of rewriting files.
        -l, --list               List files whose formatting is incorrect.
        -w, --write              Write result to (source) file instead of STDOUT.
        -F, --stdin-file=<s>     Optionally provide file path when using STDIN.
        -D, --diff-format=<s>    Display diffs using format: unified, rcs, context

        -v, --version            Print version and exit
        -h, --help               Show this message
    EOF
  end

  it 'prints help information when given -h flag' do
    out, s = Open3.capture2("#{fmt_bin} -h")

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(expected_help)
  end

  it 'prints help information when given --help flag' do
    out, s = Open3.capture2("#{fmt_bin} --help")

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(expected_help)
  end
end
