class Sieve
  def initialize(num)
    @num = num
  end

  def set_not_prime(base, not_prime)
    x = base + base
    until x > @num
      not_prime[x] = true
      x += base
    end
  end

  def primes
    np = (0..@num).select { |_x| false }
    np[0] = true
    np[1] = true
    (2..@num).each_with_object(np, &method(:set_not_prime))
    (2..@num).reject { |x| np[x] }
  end
end
