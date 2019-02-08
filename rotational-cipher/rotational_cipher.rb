class RotationalCipher
  def self.rotate(plaintext, num)
    plaintext.chars.collect { |char|
      base = (char =~ /[A-Z]/ ? 'A' : 'a').ord
      char =~ /[A-Za-z]/ ? ((char.ord - base + num + 26) % 26 + base).chr : char
    }.join
  end
end
