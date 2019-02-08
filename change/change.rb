class Change
  class ImpossibleCombinationError < StandardError
    def initialize(msg = '') end
  end

  class NegativeTargetError < StandardError
    def initialize(msg = '') end
  end

  def self.generate(coins, total_change)
    Change.new(coins).change_for(total_change)
  end

  attr_reader :coins
  def initialize(coins)
    @coins = coins
  end

  def minimum_solution(current, new)
    return current if new.nil?
    return new if current.nil?
    return new if new.size < current.size

    current
  end

  def apply_coin_to_row(row, coin)
    new_row = row.dup
    row.each_with_index do |collection, sum|
      new_row[sum] = collection
      next if new_row[sum - coin].nil? || coin > sum

      new_row[sum] = minimum_solution(
        collection, new_row[sum - coin] + [coin]
      )
    end
    new_row
  end

  # uses a dynamic approach similar to the knapsack problem solution,
  # but preserves only the previous row in the table
  #
  # Dynamic table key:
  # - The row index (r) is used to slice <coins>
  # - The column index (c) is the sum value
  # - Each cell contains the minimum collection of coins
  #   that represents the target value, using only coins[0:r]
  # - If a cell value is nil, coins[0:r] cannot represent c
  # - Ex: let (coins=[1,5,10])
  #       table[r, 0] = [] for all r
  #       table[0, c] = nil for all c > 1
  #       table[1, 22] = [1,1,5,5,5,5]
  #       table[2, 22] = [1,1,10,10]
  # - The solution to change_for(total_change) is found
  #   at table[@coins.size, total_change].
  def change_for(total_change)
    raise NegativeTargetError if total_change < 0

    final_row = coins.reduce(
      [[]] + [nil] * total_change,
      &method(:apply_coin_to_row)
    )

    raise ImpossibleCombinationError if final_row[-1].nil?

    final_row[-1]
  end
end
