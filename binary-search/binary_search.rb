class BinarySearch
  attr_accessor :list
  def initialize(list)
    @list = list
    raise ArgumentError if list != list.sort
  end

  def middle
    @list.size / 2
  end

  def midpoint(left, right)
    (right - left) / 2 + left
  end

  def search_start
    [0, middle, list.size]
  end

  def do_search
    p, r, q = search_start
    while p < r
      return r if list[r] == data

      if list[r] < data
        q = r
      else
        p = r
      end
      r = midpoint(p, q)
    end
  end

  def search_for(_data)
    r = do_search
    raise RuntimeError if r.nil?

    r
  end
end
