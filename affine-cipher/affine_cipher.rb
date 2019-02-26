# important ascii codes: a=97
NON_ALPHANUMERIC = '^a-z0-9'.freeze
ORD_A = 'a'.ord
ALPHA_SZ = 26

class Affine
  def initialize(key_a, key_b)
    raise ArgumentError unless key_a.gcd(ALPHA_SZ) == 1

    @char_map = self.class.generate_char_map(key_a, key_b)
  end

  def self.generate_char_map(key_a, key_b)
    ('a'..'z').zip((0..ALPHA_SZ - 1).map { |char|
      (((key_a * char + key_b) % ALPHA_SZ) + ORD_A).chr
    }).to_h
  end

  def clean(text)
    text.downcase.tr(NON_ALPHANUMERIC, '')
  end

  def transcode(text, mapping)
    clean(text).tr(mapping.keys.join, mapping.values.join)
  end

  def encode(plaintext)
    transcode(plaintext, @char_map)
      .scan(/.{1,5}/)
      .join(' ')
  end

  def decode(ciphertext)
    transcode(ciphertext, @char_map.invert.to_h)
  end
end
