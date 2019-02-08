class PhoneNumber
  def self.digit?(char)
    char =~ /\d/
  end

  def self.valid_area_code?(number)
    number[0] =~ /[^01]/
  end

  def self.valid_exchange_code?(number)
    number[3] =~ /[^01]/
  end

  def self.clean(number)
    number = number.chars.select(&method(:digit?)).join
    number = number[1..-1] if number.length == 11 && number[0] == '1'
    return nil unless number.length == 10
    return nil unless valid_area_code?(number)
    return nil unless valid_exchange_code?(number)

    number
  end
end
