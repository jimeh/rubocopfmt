require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Version output' do
  let(:expected_version) do
    "rubocopfmt #{RuboCopFMT::VERSION} (rubocop #{RuboCop::Version::STRING})\n"
  end

  it 'prints version information when given -v flag' do
    stdout, status = Open3.capture2("#{fmt_bin} -v")

    expect(status).to eq(0)
    expect(stdout).to eq(expected_version)
  end

  it 'prints version information when given --version flag' do
    stdout, status = Open3.capture2("#{fmt_bin} --version")

    expect(status).to eq(0)
    expect(stdout).to eq(expected_version)
  end
end
