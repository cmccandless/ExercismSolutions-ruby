class CollatzConjecture
  def self.steps(num)
    raise ArgumentError if num < 1

    steps = 0
    until num == 1
      num = num.even? ? num / 2 : 3 * num + 1
      steps += 1
    end
    steps
  end
end
