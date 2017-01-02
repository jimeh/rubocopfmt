$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubocopfmt'

RSpec.configure do |config|
  config.order = :random
end

class String
  def undent
    gsub(/^.{#{slice(/^ +/).length}}/, '')
  end
end

def get_fixture_path(name)
  File.expand_path("../integration/fixtures/#{name}.rb", __FILE__)
end

def get_fixture_file(name)
  tmp = Tempfile.new(name.to_s)
  tmp.write(File.read(get_fixture_path(name)))
  tmp.rewind
  tmp.close
  tmp
end

def get_fixture(name)
  File.read(get_fixture_path(name))
end

def fmt_bin
  File.expand_path('../../exe/rubocopfmt', __FILE__)
end
