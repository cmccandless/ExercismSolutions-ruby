class Crypto
  def initialize(text)
    @text = text
  end

  def normalize_plaintext
    @text.downcase.chars.select { |c| c =~ /[\da-z]/ }.join
  end

  def size
    Math.sqrt(normalize_plaintext.length).ceil
  end

  def plaintext_segments
    return [] if size.zero?

    normalize_plaintext
      .chars
      .each_slice(size)
      .collect { |seg| seg.join('') }
  end

  def ciphertext
    pts = plaintext_segments
    Array.new(size) { |i|
      pts.collect { |seg| seg.length <= i ? ' ' : seg[i] }.join
    }.join(' ')
  end
end
