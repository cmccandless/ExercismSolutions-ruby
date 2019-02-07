require 'set'
class Robot
  attr_reader :name
  @max_name = 26 * 26 * 1000
  @available = (0..@max_name - 1).to_a.shuffle
  def initialize
    @name = ''
    reset
  end

  def self.letter_at(index_from_a)
    (index_from_a + 'A'.ord).chr
  end

  def self.forget
    @available = (0..@max_name - 1).to_a.shuffle
  end

  def self.rand_name
    a, r = @available.pop.divmod(26_000)
    b, r = r.divmod(1000)
    [a, b].map(&method(:letter_at)).join + r.to_s.rjust(3, '0')
  end

  def reset
    @name = self.class.rand_name
  end
end
