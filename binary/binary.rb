class Binary
  def self.to_decimal(base2)
    raise ArgumentError unless '01'[base2[-1]]
    return base2.to_i if base2.length == 1

    base2[-1].to_i + 2 * to_decimal(base2[0..-2])
  end
end
