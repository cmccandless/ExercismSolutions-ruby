class SumOfMultiples
  def initialize(*factors)
    @factors = factors
  end

  def generate_multiples(factor_max)
    factor, max = *factor_max
    return [0] if factor.zero?

    (1..max / factor).collect(&factor.method(:*))
  end

  def to(max)
    @factors.zip(Array.new(@factors.length, max))
            .flat_map(&method(:generate_multiples))
            .uniq
            .reject(&max.method(:<=))
            .reduce(0, :+)
  end
end
