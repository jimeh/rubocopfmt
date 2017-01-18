require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Add single blank line' do
  it 'When diffing with RCS format, a actual blank line is output' do
    input = get_fixture(:add_single_blank_line_input)
    output = get_fixture('add_single_blank_line.rcs.diff')

    out, s = Open3.capture2("#{fmt_bin} -D rcs", stdin_data: input)

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(output)
  end
end
