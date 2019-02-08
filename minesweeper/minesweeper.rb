ValueError = Exception
class Board
  def self.transform(board)
    new(board).transform
  end

  def initialize(board)
    @board = board
    raise ArgumentError unless valid?
  end

  def valid?
    return false if @board.empty?

    @board.each_with_index.all? do |line, index|
      return false unless line.size == @board[0].size

      line =~
        if [0, @board.size - 1].include?(index)
          /^\+-+\+$/
        else
          /^\|[ *]+\|$/
        end
    end
  end

  def neighbors
    (-1..1).to_a.product((-1..1).to_a).to_a
  end

  def mine?(row_index, col_index, row_offset, col_offset)
    dy = row_index + row_offset
    dx = col_index + col_offset
    dy >= 0 && dy < @board.size &&
      dx >= 0 && dx < @board[dy].size &&
      @board[dy][dx] == '*'
  end

  def transform_row(row, row_index)
    row.chars.each_with_index.map { |value, col_index|
      if value == ' '
        neighbors.count { |m, n|
          mine?(row_index, col_index, m, n)
        }.to_s
      else
        value
      end
    }.join.tr('0', ' ')
  end

  def transform
    @board.each_with_index.map(&method(:transform_row))
  end
end
