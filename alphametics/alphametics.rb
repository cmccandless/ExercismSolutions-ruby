# Finished in 14.542947s, 0.6189 runs/s, 0.6189 assertions/s.
# 9 runs, 9 assertions, 0 failures, 0 errors, 0 skips

class Alphametics
  @operators = {
    '+' => ->(x, y) { x + y },
    '==' => ->(x, y) { x == y }
  }.to_h

  def self.perform_op(current, pair)
    op, operand = *pair
    @operators[op].call(current, operand.to_i)
  end

  def self.evaluate(input)
    return false if input =~ /\b0/

    ('+ ' + input)
      .split(' ')
      .each_slice(2)
      .reduce(0, &method(:perform_op))
  end

  def self.candidates(size)
    '9876543210'.chars
                .permutation(size)
                .lazy
  end

  def self.uniq_letters(expr)
    expr.chars.uniq.select { |ch| ch =~ /[A-Z]/ }
  end

  def self.solve(expr)
    lss = uniq_letters(expr)
    lss_s = lss.join
    solution = candidates(lss.length).find do |perm|
      evaluate(expr.tr(lss_s, perm.join))
    end

    return {} if solution.nil?

    lss.zip(solution.map(&:to_i)).to_h
  end
end
