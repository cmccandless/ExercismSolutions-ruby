class FoodChain
  @animal = %w[fly spider bird cat dog goat cow horse]
  @spider = ' wriggled and jiggled and tickled inside her.'
  @extra = [
    '',
    "It#{@spider}",
    'How absurd to swallow a bird!',
    'Imagine that, to swallow a cat!',
    'What a hog, to swallow a dog!',
    'Just opened her throat and swallowed a goat!',
    "I don't know how she swallowed a cow!",
    "She's dead, of course!"
  ]
  def self.start(verse_num)
    line = "I know an old lady who swallowed a #{@animal[verse_num]}."
    return line if verse_num <= 0

    [line, @extra[verse_num]]
  end

  def self.last
    [
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
  end

  def self.middle(verse_num)
    return last if verse_num.zero?
    return [] if verse_num == 7

    nxt = verse_num - 1
    middle(nxt).unshift(
      "She swallowed the #{@animal[verse_num]}" \
      " to catch the #{@animal[nxt]}#{nxt == 1 ? " that#{@spider}" : '.'}"
    )
  end

  def self.song
    verses = (0..7).collect do |verse_num|
      [start(verse_num), middle(verse_num), (verse_num == 7 ? [] : '')].flatten
    end
    verses.join("\n") + "\n"
  end
end
