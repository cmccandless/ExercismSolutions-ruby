class Matrix
  def initialize(input)
    @grid = input.split("\n").collect do |line|
      line.split(' ')
          .collect(&:to_i)
    end
  end

  def rows
    @grid.to_a
  end

  def columns
    @grid.transpose
  end
end
