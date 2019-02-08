class Integer
  def factors
    (2..Math.sqrt(self).floor).reduce([1]) do |factors, x|
      if self % x != 0
        factors
      elsif self / x == x
        factors.push(x)
      else
        factors.push(x).push(self / x)
      end
    end
  end
end

class PerfectNumber
  def self.classify(num)
    raise RuntimeError if num < 2

    case num <=> num.factors.reduce(0, :+)
    when -1
      'abundant'
    when 0
      'perfect'
    when 1
      'deficient'
    end
  end
end
