class Array
  def accumulate
    collect { |x| yield x }
  end
end
