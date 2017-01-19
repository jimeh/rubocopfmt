require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Insert empty lines' do
  it 'with RCS diff format' do
    input = get_fixture(:insert_empty_lines)
    output = get_fixture('insert_empty_lines.rcs.diff')

    out, s = Open3.capture2("#{fmt_bin} -D rcs", stdin_data: input)

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(output)
  end
end
