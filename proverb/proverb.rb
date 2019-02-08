class Proverb
  def initialize(*chain, qualifier: '')
    @chain = chain
    @qualifier = qualifier
  end

  def line_at(index)
    "For want of a #{@chain[index]} the #{@chain[index + 1]}"
  end

  def last_line
    'And all for the want of a ' \
      "#{@qualifier.empty? ? '' : "#{@qualifier} "}#{@chain[0]}."
  end

  def to_s
    Array.new(@chain.length - 1, &method(:line_at))
         .push(last_line)
         .join(" was lost.\n")
  end
end
