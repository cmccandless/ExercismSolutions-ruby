class Say
  def initialize(num)
    @num = num
    raise ArgumentError if num >= 1_000_000_000_000
    raise ArgumentError if num < 0
  end

  def digit(num)
    {
      0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three',
      4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven',
      8 => 'eight', 9 => 'nine', 10 => 'ten', 11 => 'eleven',
      12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
      15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen',
      18 => 'eighteen', 19 => 'nineteen'
    }[num]
  end

  def ten(tenth)
    {
      0 => '', 1 => 'ten', 2 => 'twenty', 3 => 'thirty',
      4 => 'forty', 5 => 'fifty', 6 => 'sixty',
      7 => 'seventy', 8 => 'eighty', 9 => 'ninety'
    }[tenth]
  end

  def powers
    [
      1_000_000_000,
      1_000_000,
      1_000,
      100
    ]
  end

  def label(power)
    {
      1_000_000_000 => ' billion',
      1_000_000 => ' million',
      1_000 => ' thousand',
      100 => ' hundred',
      10 => ''
    }[power]
  end

  def in_english_under_hundred(num)
    return digit(num) if num < 20

    t, d = num.divmod(10)
    return ten(t) if d.zero?

    "#{ten(t)}-#{digit(d)}"
  end

  def get_parts(num)
    parts = powers.each_with_object([]) do |pow, pss|
      q, num = num.divmod(pow)
      pss.push([pow, q])
      pss.push([10, num]) if pow == 100 && num < 100
    end
    parts.reject { |_, part| part.zero? }
  end

  def in_english(num = nil)
    num = @num if num.nil?
    return in_english_under_hundred(num) if num < 100

    get_parts(num)
      .map { |pow, part| "#{in_english(part)}#{label(pow)}" }
      .join(' ')
  end
end
