class Queens
  def valid_position?(pos)
    pos.nil? || pos.all? { |c| c >= 0 && c <= 7 }
  end

  def initialize(white: nil, black: nil)
    raise ArgumentError unless valid_position?(white)
    raise ArgumentError unless valid_position?(black)

    @white = white
    @black = black
  end

  def attack_row?
    @white[0] == @black[0]
  end

  def attack_column?
    @white[1] == @black[1]
  end

  def attack_diagonal?
    (@white[0] - @black[0]).abs == (@white[1] - @black[1]).abs
  end

  def attack?
    attack_row? || attack_column? || attack_diagonal?
  end
end
