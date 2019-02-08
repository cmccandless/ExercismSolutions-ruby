class Triplet
  attr_reader :sum
  attr_reader :product
  def initialize(*values)
    @sides = values.sort
    @sum = values.reduce(0, :+)
    @product = values.reduce(1, :*)
  end

  def pythagorean?
    a, b, c = *@sides
    a * a + b * b == c * c
  end

  def self.maxmin(left, right)
    left > right ? [left, right] : [right, left]
  end

  def self.valid_pair?(pair)
    m, n = *pair
    (m - n).odd? && m.gcd(n) == 1
  end

  def self.create_triplet(m_val, n_val, b_val)
    m2 = m_val * m_val
    n2 = n_val * n_val
    maxmin(m2 - n2, b_val).reverse.push(m2 + n2)
  end

  def self.primitive_triplets(b_val)
    b_div2 = b_val / 2
    (2..b_div2 + 1).select { |m| (b_div2 % m).zero? }
                   .collect { |m| maxmin(m, b_div2 / m) }
                   .select(&method(:valid_pair?))
                   .collect { |m, n|
      create_triplet(m, n, b_val)
    }.uniq
  end

  def self.fill_multiples(triplets, max_factor)
    triplets.to_a
            .flat_map do |x, y, z|
      ts = [[x, y, z]]
      while ts[-1][-1] + z <= max_factor
        prev = ts[-1]
        ts.push([prev[0] + x, prev[1] + y, prev[2] + z])
      end
      ts
    end
  end

  def self.filter_result(result, max_factor, min_factor, sum)
    result.select { |a, _b, c| a >= min_factor && c <= max_factor }
          .uniq
          .map { |values| Triplet.new(*values) }
          .select { |t| sum.nil? || t.sum == sum }
  end

  def self.where(max_factor: 10, min_factor: 2, sum: nil)
    result = (4..max_factor + 1).step(4)
                                .flat_map(&method(:primitive_triplets))
                                .uniq
    result = fill_multiples(result, max_factor)
    filter_result(result, max_factor, min_factor, sum)
  end
end
