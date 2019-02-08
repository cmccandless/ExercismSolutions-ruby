class TwoBucket
  attr_reader :moves
  attr_reader :goal_bucket
  attr_reader :other_bucket
  def initialize(size1, size2, goal, start_bucket)
    @sizes = [size1, size2]
    @goal = goal
    @start_bucket = start_bucket
    @goal_bucket = nil
    @other_bucket = nil
    @moves = calculate
  end

  def visit_state(to_visit, visited, state)
    return if state.invalid? || visited.key?(state.key)

    visited[state.key] = true
    state.next_states(&to_visit.method(:push))
  end

  def finalize(state)
    goal_index = state.buckets.index(@goal)
    @goal_bucket = goal_index.zero? ? 'one' : 'two'
    @other_bucket = state.buckets[1 - goal_index]
    state.moves
  end

  def calculate
    to_visit = []
    visited = {}
    state = State.new(@sizes, @start_bucket)
                 .fill(@start_bucket == 'one' ? 0 : 1)
    until state.buckets.include?(@goal)
      visit_state(to_visit, visited, state)
      state = to_visit.shift
    end
    finalize(state)
  end
end

class State
  attr_reader :moves
  attr_reader :buckets
  def initialize(sizes, start_bucket, buckets = [0, 0], moves = 0)
    @sizes = sizes
    @start_bucket = start_bucket
    @buckets = buckets
    @moves = moves
  end

  def goal_bucket
    buckets.index(@goal).zero? ? 'one' : 'two'
  end

  def create_with(new_buckets)
    State.new(
      @sizes, @start_bucket,
      new_buckets, @moves + 1
    )
  end

  def empty(index)
    create_with(index.zero? ? [0, buckets[1]] : [buckets[0], 0])
  end

  def fill(index)
    create_with(
      index.zero? ? [@sizes[0], buckets[1]] : [buckets[0], @sizes[1]]
    )
  end

  def amount_movable(index)
    [buckets[1 - index], @sizes[index] - buckets[index]].min
  end

  def consolidate(index)
    amount = amount_movable(index)
    target = buckets[index] + amount
    src = buckets[1 - index] - amount
    create_with(index.zero? ? [target, src] : [src, target])
  end

  def key
    buckets.join(',')
  end

  def invalid?
    non_start_index = @start_bucket == 'one' ? 1 : 0
    invalid_buckets = [0, 0]
    invalid_buckets[non_start_index] = @sizes[non_start_index]
    buckets == invalid_buckets
  end

  def can_empty?(index)
    !buckets[index].zero?
  end

  def can_fill?(index)
    buckets[index] != @sizes[index]
  end

  def can_consolidate?(index)
    can_fill?(index) && can_empty?(1 - index)
  end

  def internal_next_states
    [0, 1].each_with_object([]) do |i, states|
      states.push(empty(i)) if can_empty?(i)
      states.push(fill(i)) if can_fill?(i)
      states.push(consolidate(i)) if can_consolidate?(i)
    end
  end

  def next_states(&block)
    states = internal_next_states
    return states unless block_given?

    states.each(&block.method(:call))
  end
end
