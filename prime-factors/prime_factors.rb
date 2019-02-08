class PrimeFactors
  # https://rosettacode.org/wiki/Miller%E2%80%93Rabin_primality_test#Ruby
  def self.mod_exp(base, exp, mod)
    raise ArgumentError, 'negative exponent' if exp < 0

    prod = 1
    base = base % mod
    until exp.zero?
      prod = (prod * base) % mod if exp.odd?
      exp >>= 1
      base = (base * base) % mod
    end
    prod
  end

  def self.process_x(num, x_start, times)
    x = x_start
    (1..times - 1).each do |_|
      x = mod_exp(x, 2, num) # x = (x**2) % n
      return nil if x == 1
      break if x == num - 1
    end
    x
  end

  def self.run_iterations(num, iterations, d_val, times)
    iterations.times do
      a = 2 + rand(num - 4)
      x = mod_exp(a, d_val, num) # x = (a**d) % n
      next if [1, num - 1].include? x

      x = process_x(num, x, times)
      return false if x.nil? || x != num - 1
    end
    true # probably
  end

  def self.prime?(num, iterations)
    return false if num < 2
    return true if num < 4

    ds = [num - 1, 0]
    ds = [ds[0] / 2, ds[1] + 1] while ds[0].even?
    run_iterations(num, iterations, *ds)
  end

  def self.next_prime(num)
    num += 1
    num += 1 until prime?(num, 5)
    num
  end

  def self.loop_helper(num, factors, candidate)
    if (num % candidate).zero?
      factors.push(candidate)
      [num / candidate, candidate]
    else
      [num, next_prime(candidate)]
    end
  end

  def self.for(num)
    factors = []
    x = 2
    num, x = loop_helper(num, factors, x) while num != 1
    factors
  end
end
