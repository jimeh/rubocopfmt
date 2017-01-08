require 'spec_helper'
require 'open3'

RSpec.describe 'Integration: Show diff of corrections' do
  ['-d', '--diff'].each do |flag|
    it "Show diff of corrections for STDIN source when passed #{flag} flag" do
      input = get_fixture(:basic3_input)
      diff = get_fixture('basic3.unified.diff').strip

      out, s = Open3.capture2("#{fmt_bin} #{flag}", stdin_data: input)
      lines = out.split("\n")

      expect(s.exitstatus).to eq(0)
      expect(lines[0]).to match(/^\-\-\- .+diffy.+/)
      expect(lines[1]).to match(/^\+\+\+ .+diffy.+/)
      expect(lines[2..-1].join("\n")).to eq(diff)
    end

    it "Show diff of corrections for file paths when passed #{flag} flag" do
      examples = [
        {
          file: get_fixture_file(:basic3_input),
          diff: get_fixture('basic3.unified.diff').strip.split("\n")
        },
        {
          file: get_fixture_file(:basic1_input),
          diff: get_fixture('basic1.unified.diff').strip.split("\n")
        }
      ]

      paths = examples.map { |e| e[:file].path }
      out, s = Open3.capture2(
        "#{fmt_bin} #{flag} #{paths.join(' ')}"
      )

      expect(s.exitstatus).to eq(0)

      lines = out.split("\n")
      offset = 0
      examples.each do |e|
        expect(lines[0 + offset])
          .to match(%r{^diff #{e[:file].path} rubocopfmt/#{e[:file].path}})
        expect(lines[1 + offset]).to match(/^\-\-\- .+diffy.+/)
        expect(lines[2 + offset]).to match(/^\+\+\+ .+diffy.+/)
        expect(lines[3 + offset, e[:diff].size]).to eq(e[:diff])

        offset += 3 + e[:diff].size
      end
    end
  end

  ['-D', '--diff-format'].each do |flag|
    it "Supports outputting diffs in Unified format using #{flag} flag" do
      input = get_fixture(:basic3_input)
      diff = get_fixture('basic3.unified.diff').strip

      out, s = Open3.capture2("#{fmt_bin} #{flag} unified", stdin_data: input)
      lines = out.split("\n")

      expect(s.exitstatus).to eq(0)
      expect(lines[0]).to match(/^\-\-\- .+diffy.+/)
      expect(lines[1]).to match(/^\+\+\+ .+diffy.+/)
      expect(lines[2..-1].join("\n")).to eq(diff)
    end

    it "Supports outputting diffs in RCS format using #{flag} flag" do
      input = get_fixture(:basic3_input)
      diff = get_fixture('basic3.rcs.diff')

      out, s = Open3.capture2("#{fmt_bin} #{flag} rcs", stdin_data: input)

      expect(s.exitstatus).to eq(0)
      expect(out).to eq(diff)
    end
  end

  ['-D', '--diff-format'].each do |flag|
    it "Supports outputting diffs in Context format using #{flag} flag" do
      input = get_fixture(:basic3_input)
      diff = get_fixture('basic3.context.diff').strip

      out, s = Open3.capture2("#{fmt_bin} #{flag} context", stdin_data: input)
      lines = out.split("\n")

      expect(s.exitstatus).to eq(0)
      expect(lines[0]).to match(/^\*\*\* .+diffy.+/)
      expect(lines[1]).to match(/^\-\-\- .+diffy.+/)
      expect(lines[2..-1].join("\n")).to eq(diff)
    end
  end
end
