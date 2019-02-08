class TwelveDays
  def self.song
    verses(1, 12)
  end

  def self.ordinal(num)
    ['', 'first', 'second', 'third', 'fourth',
     'fifth', 'sixth', 'seventh', 'eighth',
     'ninth', 'tenth', 'eleventh', 'twelfth'][num]
  end

  def self.gift(num)
    [
      '', 'a Partridge in a Pear Tree',
      'two Turtle Doves', 'three French Hens',
      'four Calling Birds', 'five Gold Rings',
      'six Geese-a-Laying', 'seven Swans-a-Swimming',
      'eight Maids-a-Milking', 'nine Ladies Dancing',
      'ten Lords-a-Leaping', 'eleven Pipers Piping',
      'twelve Drummers Drumming'
    ][num]
  end

  def self.verses(start, stop)
    (start..stop).map(&method(:verse)).join("\n")
  end

  def self.verse(verse_num)
    gifts = *(1..verse_num).map(&method(:gift)).reverse
    gifts[-1] = 'and ' + gifts[-1] unless verse_num == 1
    "On the #{ordinal(verse_num)} day of Christmas my true " \
      "love gave to me: #{gifts.join(', ')}.\n"
  end
end
