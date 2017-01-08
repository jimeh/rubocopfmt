require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Load .rubocop.yml relative to source file' do
  it 'correction respects settings in .rubocop.yml when given a file path' do
    input_file = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/input.rb', __FILE__
    )
    output_file = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/output.rb', __FILE__
    )

    out, s = Open3.capture2("#{fmt_bin} \"#{input_file}\"")

    expect(s.exitstatus).to eq(0)
    expect(out).to eq(File.read(output_file, mode: 'rb'))
  end

  it 'correction respects settings in .rubocop.yml via STDIN and --stdin-file option' do
    input_file = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/input.rb', __FILE__
    )
    output_file = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/output.rb', __FILE__
    )

    out, s = Open3.capture2(
      "#{fmt_bin} --stdin-file \"#{output_file}\"",
      stdin_data: File.read(input_file, mode: 'rb')
    )

    expect(out).to eq(File.read(output_file, mode: 'rb'))
    expect(s.exitstatus).to eq(0)
  end

  it 'correction respects settings in .rubocop.yml via STDIN and -F option' do
    input_file = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/input.rb', __FILE__
    )
    output_file = File.expand_path(
      '../load_rubocop_yml_relative_to_source_file/output.rb', __FILE__
    )

    out, s = Open3.capture2(
      "#{fmt_bin} -F \"#{output_file}\"",
      stdin_data: File.read(input_file, mode: 'rb')
    )

    expect(out).to eq(File.read(output_file, mode: 'rb'))
    expect(s.exitstatus).to eq(0)
  end
end
