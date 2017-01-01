require 'rubocopfmt/options_parser'

module RuboCopFMT
  class Options
    def files
      @files.nil? ? [] : @files
    end
    attr_writer :files

    def diff
      @diff.nil? ? false : @diff
    end
    attr_writer :diff

    def list
      @list.nil? ? false : @list
    end
    attr_writer :list

    def write
      @write.nil? ? false : @write
    end
    attr_writer :write
  end
end
