require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Version output' do
  let(:expected_version) do
    "rubocopfmt #{RuboCopFMT::VERSION} " \
      "(using rubocop #{RuboCop::Version::STRING})\n"
  end

  it 'prints version information when given -v flag' do
    out, s = Open3.capture2("#{fmt_bin} -v")

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(expected_version)
  end

  it 'prints version information when given --version flag' do
    out, s = Open3.capture2("#{fmt_bin} --version")

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(expected_version)
  end
end
