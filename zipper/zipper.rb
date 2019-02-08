class Node
  attr_accessor :value, :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def ==(other)
    @value == other.value && @left == other.left && @right == other.right
  end
end

class Zipper
  attr_reader :root
  def initialize(root = nil)
    @root = root
    @parent = []
    @current = root
  end

  def self.from_tree(tree)
    Zipper.new(tree)
  end

  def to_tree
    @root
  end

  def value
    @current.value
  end

  def left
    if @current.left.nil?
      nil
    else
      @parent.push(@current)
      @current = @current.left
      self
    end
  end

  def right
    if @current.right.nil?
      nil
    else
      @parent.push(@current)
      @current = @current.right
      self
    end
  end

  def up
    if @parent.empty?
      nil
    else
      @current = @parent.pop
      self
    end
  end

  # rubocop:disable Naming/AccessorMethodName
  def set_value(value)
    @current.value = value
    self
  end

  def set_left(node)
    @current.left = node
    self
  end

  def set_right(node)
    @current.right = node
    self
  end
  # rubocop:enable Naming/AccessorMethodName

  def ==(other)
    @root == other.root
  end
end
