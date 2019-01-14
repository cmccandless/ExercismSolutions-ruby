# important ascii codes: a=97
class Affine
  def initialize(key_a, key_b)
    raise ArgumentError unless key_a.gcd(26) == 1

    @key_a = key_a
    @mmi_a = (1..26).find { |n| (key_a * n) % 26 == 1 }
    @key_b = key_b
  end

  def encode(plaintext)
    plaintext.downcase
             .tr('^a-z0-9', '')
             .tr(
               'a-z',
               (0..25).collect { |x|
                 (((@key_a * x + @key_b) % 26) + 97).chr
               }.join
             )
             .scan(/.{1,5}/)
             .join(' ')
  end

  def decode(ciphertext)
    ciphertext.tr('^a-z0-9', '')
              .tr(
                'a-z',
                (0..25).collect { |y|
                  ((@mmi_a * (y - @key_b + 26) % 26) + 97).chr
                }.join
              )
  end
end
