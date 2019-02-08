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

  def do_search(data)
    p, r, q = search_start
    while p < r
      return r if list[r] == data

      if list[r] < data
        p = r
      else
        q = r
      end
      r = midpoint(p, q)
    end
  end

  def search_for(data)
    r = do_search(data)
    raise RuntimeError if r.nil?

    r
  end
end
