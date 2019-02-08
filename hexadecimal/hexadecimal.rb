class Hexadecimal
  def initialize(hex)
    @hex = hex
  end

  def digits
    {
      '0' => 0, '1' => 1, '2' => 2, '3' => 3,
      '4' => 4, '5' => 5, '6' => 6, '7' => 7,
      '8' => 8, '9' => 9, 'a' => 10, 'b' => 11,
      'c' => 12, 'd' => 13, 'e' => 14, 'f' => 15
    }
  end

  def to_decimal
    return 0 if @hex =~ /[^\da-f]/

    ds = digits
    @hex.chars.reduce(0) do |result, digit|
      (result << 4) + ds[digit]
    end
  end
end
