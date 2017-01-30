class Foo
  BAR = 'hello'.freeze

  def initialize; end

  def world
    [:foo, :bar].each_with_index do |sym, _index|
      puts sym
    end
  end

  def this_is_a_long_method_name_because_it_just_is_and_deal_with_or_die_you_scum
    puts 'yep, too long method name'
  end
end
