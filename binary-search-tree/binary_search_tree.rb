class Bst
  attr_reader :data
  attr_reader :left
  attr_reader :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def insert_left(value)
    if @left
      @left.insert(value)
    else
      @left = Bst.new(value)
    end
  end

  def insert_right(value)
    if @right
      @right.insert(value)
    else
      @right = Bst.new(value)
    end
  end

  def insert(value)
    if value <= @data
      insert_left(value)
    else
      insert_right(value)
    end
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    @left.each(&block) if @left

    yield(@data)
    @right.each(&block) if @right
  end
end
