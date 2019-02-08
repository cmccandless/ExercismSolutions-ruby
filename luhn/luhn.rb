class Luhn
  def self.get_digits(num)
    num.tr('^0-9', '').chars.collect(&:to_i)
  end

  def self.valid?(num)
    return false if num =~ /[^\d ]/

    digits = get_digits(num)
    do_double = true
    digits.size > 1 && digits.reverse.reduce(0) { |result, digit|
      result + if (do_double = !do_double)
                 2 * (digit > 4 ? digit - 4.5 : digit)
               else
                 digit
               end
    }.%(10).zero?
  end
end
