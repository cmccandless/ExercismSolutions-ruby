class Integer
  def to_roman
    roman_digits = [
      ['M', 1000], ['CM', 900], ['D', 500], ['CD', 400], ['C', 100],
      ['XC', 90], ['L', 50], ['XL', 40], ['X', 10], ['IX', 9],
      ['V', 5], ['IV', 4], ['I', 1]
    ]
    roman_digits.each do |digit, value|
      next unless self >= value

      return digit + (self - value).to_roman
    end
    ''
  end
end
