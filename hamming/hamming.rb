class Hamming
  def self.compare_pair_abs(pair)
    (pair[0] <=> pair[1]).abs
  end

  def self.compute(left, right)
    raise(ArgumentError) if left.length != right.length

    return 0 if left.empty?

    left.chars.zip(right.chars).collect(&method(:compare_pair_abs)).reduce(:+)
  end
end
