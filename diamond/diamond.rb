class Diamond
  def self.mirror(lst)
    lst + lst[0..-2].reverse
  end

  def self.make_row(ord, width)
    x = ord - 'A'.ord
    s = ' ' * (width - x) + ord.chr + ' ' * x
    mirror(s) + "\n"
  end

  def self.make_diamond(char)
    a = 'A'.ord
    d = char.ord
    w = d - a
    lines = (a..d).collect do |i|
      make_row(i, w)
    end
    mirror(lines).join
  end
end
