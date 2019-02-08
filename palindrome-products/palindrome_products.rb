class Palindromes
  attr_reader :largest
  attr_reader :smallest
  def initialize(max_factor: 1000, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    @largest = nil
    @smallest = nil
  end

  def palindrome?(num)
    num == num.to_s.reverse.to_i
  end

  def init_smallest
    @smallest = Product.new(value: @max_factor * @max_factor, factors: [])
  end

  def init_largest
    @largest = Product.new(value: @min_factor, factors: [])
  end

  def init
    init_smallest
    init_largest
  end

  def generate_smallest(product, m_val, n_val)
    case @smallest.value <=> product
    when 0
      @smallest.factors.push([m_val, n_val])
    when 1
      @smallest = Product.new(value: product, factors: [[m_val, n_val]])
    end
  end

  def generate_largest(product, m_val, n_val)
    case @largest.value <=> product
    when 0
      @largest.factors.push([m_val, n_val])
    when -1
      @largest = Product.new(value: product, factors: [[m_val, n_val]])
    end
  end

  def check_factor_pair(m_val, n_val)
    p = m_val * n_val
    return unless palindrome?(p)

    generate_smallest(p, m_val, n_val)
    generate_largest(p, m_val, n_val)
  end

  def generate
    init
    (@min_factor..@max_factor).each do |m|
      (m..@max_factor).each do |n|
        check_factor_pair(m, n)
      end
    end
    @smallest.factors = @smallest.factors.uniq
    @largest.factors = @largest.factors.uniq
  end
end
class Product
  attr_reader :value
  attr_accessor :factors
  def initialize(value: 0, factors: [])
    @value = value
    @factors = factors
  end
end
