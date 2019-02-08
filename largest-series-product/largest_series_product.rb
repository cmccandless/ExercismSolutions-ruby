class Series
  def initialize(series)
    @series = series
    raise ArgumentError if series =~ /[^\d]/
  end

  def largest_product(size)
    return 1 if size.zero?
    raise ArgumentError if size > @series.size

    @series.chars
           .each_cons(size)
           .collect { |slice|
             slice.collect(&:to_i)
                  .reduce(:*)
           }.max
  end
end
