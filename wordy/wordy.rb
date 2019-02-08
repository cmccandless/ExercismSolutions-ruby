class WordProblem
  def initialize(input)
    @input = input
  end

  def apply_op(result, operator, num)
    case operator
    when 'What is', 'plus'
      result + num
    when 'minus'
      result - num
    when 'multiplied by'
      result * num
    when 'divided by'
      result / num
    end
  end

  def answer
    @input.scan(/([A-Za-z ]+)(-?\d+)?\??/)
          .reduce(0) do |result, part|
      op, num = *part
      raise ArgumentError if num.nil?

      apply_op(result, op.strip, num.to_i)
    end
  end
end
