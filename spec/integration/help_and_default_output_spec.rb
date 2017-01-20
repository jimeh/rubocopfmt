require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Help and default output' do
  let(:expected_help) do
    <<-EOF.undent
      Usage: rubocopfmt [options] [path ...]

      Reads from STDIN if no path is given.

      Options:
        -d, --diff               Display diffs instead of rewriting files
        -l, --list               List files whose formatting is incorrect
        -w, --write              Write result to (source) file instead of STDOUT
        -S, --src-dir=<s>        Operate as if code resides in specified directory
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

  it 'prints an error if not arguments and no STDIN is given' do
    out, err, s = Open3.capture3(fmt_bin)

    expect(s.exitstatus).to eq(255)
    expect(out).to eq('')
    expect(err).to eq(
      "Error: Failed to read from STDIN.\nTry --help for help.\n"
    )
  end
end
