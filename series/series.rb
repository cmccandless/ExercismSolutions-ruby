class Series
  def initialize(nums)
    @nums = nums.chars
  end

  def slices(num)
    raise ArgumentError if num > @nums.length

    (0..@nums.length - num).collect { |i| @nums[i..num + i - 1].join }
  end
end
