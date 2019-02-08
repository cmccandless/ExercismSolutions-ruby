class Board
  def neighbors
    [-1, 0, 1].product([-1, 0, 1]).reject { |x, y| x == y }
  end

  def initialize(board)
    @board = board.collect { |line| line.tr(' ', '') }
  end

  def in_range(col, row)
    col >= 0 && row >= 0 && row < @board.size && col < @board[row].size
  end

  def init_stack
    Array.new(@board.size) { |y| [0, y, 'X', "0,#{y},X"] } +
      Array.new(@board[0].size) { |x| [x, 0, 'O', "#{x},0,O"] }
  end

  def winner?(col, row, token, _key)
    (token == 'X' && col == @board[row].size - 1) ||
      (token == 'O' && row == @board.size - 1)
  end

  def do_check?(col, row, token, _key)
    in_range(col, row) && @board[row][col] == token
  end

  def apply_offset(tuple, delta_col, delta_row)
    x, y, token, _key = tuple
    new_col = x + delta_col
    new_row = y + delta_row
    new_key = ','.join(new_col, new_row, token)
    [new_col, new_row, token, new_key]
  end

  def update_stack(stack, tuple)
    neighbors.each { |m, n| stack.push(apply_offset(tuple, m, n)) }
  end

  def winner
    visited = {}
    stack = init_stack
    until stack.empty?
      t = stack.pop
      next if !do_check?(*t) || visited[t[-1]]
      return token if winner?(*t)

      visited[t[-1]] = true
      update_stack(stack, t)
    end
    ''
  end
end
