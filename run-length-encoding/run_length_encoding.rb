class RunLengthEncoding
  def self.encode(input)
    return '' if input.empty?

    input.match(/((.)\2*)(.*)/) do |m|
      (m[1].length > 1 ? m[1].length.to_s + m[2] : m[2]) + encode(m[3])
    end
  end

  def self.decode(input)
    return '' if input.empty?

    input.match(/(\d+)?([^\d])(.*)/) do |m|
      (m[1] ? m[2] * m[1].to_i : m[2]) + decode(m[3])
    end
  end
end
