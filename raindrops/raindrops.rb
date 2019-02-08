class Raindrops
  def self.convert(num)
    @result = ''
    @result += 'Pling' if (num % 3).zero?
    @result += 'Plang' if (num % 5).zero?
    @result += 'Plong' if (num % 7).zero?
    return num.to_s if @result == ''

    @result
  end
end
