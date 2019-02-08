class CustomSet
  attr_reader :size
  def initialize(values)
    @head = nil
    return if values.empty?

    @head = BinaryNode.new(values.shift)
    values.each { |value| add(value) }
  end

  def empty?
    @head.nil?
  end

  def member?(value)
    @head && @head.traverse(value, false)
  end

  def add(value)
    if @head
      @head.traverse(value, true)
    else
      @head = BinaryNode.new(value)
    end
    self
  end

  def to_a
    return [] if empty?

    @head.to_a
  end

  def length
    to_a.length
  end

  def ==(other)
    return other == self if other.length > length

    empty? == other.empty? && to_a.zip(other.to_a).all? { |a, b| a == b }
  end

  def subset?(other)
    to_a.all? { |value| other.member?(value) }
  end

  def disjoint?(other)
    to_a.all? { |value| !other.member?(value) }
  end

  def intersection(other)
    to_a.select { |value| other.member?(value) }
  end

  def difference(other)
    to_a.reject { |value| other.member?(value) }
  end

  def union(other)
    CustomSet.new(to_a + other.to_a)
  end
end

class BinaryNode
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def traverse_left(value, add = false)
    return @left.traverse(value, add) if @left
    return false unless add

    @left = BinaryNode.new(value)
  end

  def traverse_right(value, add = false)
    return @right.traverse(value, add) if @right
    return false unless add

    @right = BinaryNode.new(value)
  end

  def traverse(value, add = false)
    case value <=> @value
    when 0
      !add
    when -1
      traverse_left(value, add)
    when 1
      traverse_right(value, add)
    end
  end

  def left_a
    return [] unless @left

    @left.to_a
  end

  def right_a
    return [] unless @right

    @right.to_a
  end

  def to_a
    left_a.push(@value).concat(right_a)
  end
end
