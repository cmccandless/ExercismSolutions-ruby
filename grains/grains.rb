class Grains
  def self.square(num)
    raise ArgumentError if num < 1 || num > 64
    return 1 if num == 1

    1 << (num - 1)
  end

  def self.total
    (1 << 64) - 1
  end
end
