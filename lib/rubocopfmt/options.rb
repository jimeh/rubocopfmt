require 'rubocopfmt/options_parser'

module RuboCopFMT
  class Options
    def paths
      @paths.nil? ? [] : @paths
    end
    attr_writer :paths

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
