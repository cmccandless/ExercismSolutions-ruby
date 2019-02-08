class BaseConverter
  def self.to_base_10(input_base, digits)
    digits.reduce(0) { |r, x| r * input_base + x }
  end

  def self.from_base_10(num, output_base)
    digits = []
    q = num
    until q <= 0
      q, r = q.divmod(output_base)
      digits.unshift(r)
    end
    digits
  end

  def self.validate(input_base, digits, output_base)
    raise ArgumentError if input_base < 2 || output_base < 2
    raise ArgumentError if digits.any? { |d| d < 0 || d >= input_base }
  end

  def self.convert(input_base, digits, output_base)
    validate(input_base, digits, output_base)
    return [0] if digits.empty? || digits.all?(&:zero?)

    from_base_10(to_base_10(input_base, digits), output_base)
  end
end
