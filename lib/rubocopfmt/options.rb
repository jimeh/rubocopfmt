module RuboCopFMT
  class Options
    attr_accessor :input
    attr_accessor :src_dir
    attr_accessor :diff_format

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

    def interactive
      @interactive.nil? ? false : @interactive
    end
    attr_writer :interactive
  end
end
