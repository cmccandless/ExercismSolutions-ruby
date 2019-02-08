class Squares
  def initialize(num)
    @num = num
  end

  def square_of_sum
    sum = (1..@num).inject(:+)
    sum * sum
  end

  def sum_of_squares
    (1..@num).reduce(0) { |sum, x| sum + x * x }
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
