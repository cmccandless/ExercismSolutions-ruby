class Trinary
  def initialize(trinary)
    @trinary = trinary
  end

  def to_decimal
    return 0 if @trinary =~ /[^012]/
    return @trinary.to_i if @trinary.length == 1

    @trinary.chars.reduce(0) do |result, digit|
      (result * 3) + digit.to_i
    end
  end
end
