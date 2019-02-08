class BeerSong
  def self.bottles(verse_num)
    return 'No more bottles' if verse_num.zero?
    return '1 bottle' if verse_num == 1

    "#{verse_num} bottles"
  end

  def self.verse(verse_num)
    line2 = if verse_num.zero?
              "Go to the store and buy some more, #{bottles(99)}"
            else
              "Take #{verse_num == 1 ? 'it' : 'one'} down and pass it " \
                "around, #{bottles(verse_num - 1).downcase}"
            end
    b = bottles(verse_num)
    "#{b} of beer on the wall, #{b.downcase} of beer.\n" \
     "#{line2} of beer on the wall.\n"
  end

  def self.recite(start, count)
    (0..count - 1).collect { |i| verse(start - i) }.join("\n")
  end
end
