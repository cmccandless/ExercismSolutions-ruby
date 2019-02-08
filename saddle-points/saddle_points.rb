class Matrix
  def initialize(input)
    @grid = input.split("\n").collect do |line|
      line.split(' ').collect(&:to_i)
    end
  end

  def rows
    @grid.to_a
  end

  def columns
    @grid.transpose
  end

  def row_max?(row, col)
    @grid[row][col] == @grid[row].max
  end

  def column_min?(row, col)
    @grid[row][col] == columns[col].min
  end

  def saddle_points
    (0..@grid.length - 1).flat_map do |y|
      (0..@grid[y].length - 1)
        .select { |x| row_max?(y, x) && column_min?(y, x) }
        .collect { |x| [y, x] }
    end
  end
end
