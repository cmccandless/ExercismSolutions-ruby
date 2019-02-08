class Array
  def max_length(start = 0)
    self[start..-1].map(&:length).max
  end
end

class Transpose
  def self.adjust_line_lengths(lines)
    lines.each_with_index.map do |line, index|
      line.rstrip.ljust(lines.max_length(index))
    end
  end

  def self.transpose(str)
    lines = str.split("\n")
    line_length = lines.max_length
    new_lines = lines.map { |line| line.ljust(line_length).chars }
                     .transpose
                     .map { |line_a| line_a.join.rstrip }
    adjust_line_lengths(new_lines).join("\n")
  end
end
