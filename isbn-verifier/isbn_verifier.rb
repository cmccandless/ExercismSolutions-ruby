class IsbnVerifier
  def self.parse_digit(digit, index)
    return nil if index > 9

    mult = (10 - index)
    return mult * 10 if index == 9 && digit == 'X'
    return mult * digit.to_i if digit =~ /\d/
  end

  def self.valid?(isbn)
    clean = isbn.tr('-', '')
    return nil unless clean.length == 10

    clean.chars
         .each_with_index
         .collect(&method(:parse_digit))
         .reduce(0) { |sum, digit|
           return nil if digit.nil?

           sum + digit
         }.%(11).zero?
  end
end
