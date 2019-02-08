class OcrNumbers
  def self.convert_digit(digit)
    digits = [0xAF, 0x09, 0x9E, 0x9B, 0x39, 0xB3, 0xB7, 0x89, 0xBF, 0xBB]
    digits.include?(digit) ? digits.index(digit).to_s : '?'
  end

  def self.convert_number(str)
    convert_digit(str.chars
                  .zip('*_*|_||_|'.chars)
                  .collect { |ch, seg| ch == seg ? 1 : 0 }
                  .join
                  .to_i(2))
  end

  def self.get_numbers(lines)
    ps, qs = lines.collect { |line|
      return [] if line.empty?

      [line[0..2], line[3..-1]]
    }
                  .transpose
    get_numbers(qs).unshift(ps[0, 3].join)
  end

  def self.validate_line_count(input)
    raise ArgumentError unless input.count("\n") % 4 == 3
  end

  def self.validate_line_width(line)
    raise ArgumentError unless (line.length % 3).zero?
  end

  def self.convert(input)
    validate_line_count(input)

    input.split("\n")
         .each_slice(4)
         .each_with_object([]) { |line_slice, numbers|
      line_slice.each(&method(:validate_line_width))

      numbers.push(
        get_numbers(line_slice).collect(&method(:convert_number)).join
      )
    }.join(',')
  end
end
