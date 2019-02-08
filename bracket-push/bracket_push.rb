class Brackets
  def self.brackets
    { '[' => ']', '{' => '}', '(' => ')' }
  end

  def self.closers
    [']', '}', ')']
  end

  def self.paired?(input)
    open = []
    input.chars.each do |ch|
      if brackets.include?(ch)
        open.push(ch)
      elsif closers.include?(ch)
        return false unless open.any? && brackets[open[-1]] == ch

        open.pop
      end
    end
    open.empty?
  end
end
