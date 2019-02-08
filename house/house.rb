class House
  @word_pairs = [
    ['lay in', "house that Jack built.\n"],
    %w[ate malt],
    %w[killed rat],
    %w[worried cat],
    %w[tossed dog],
    ['milked', 'cow with the crumpled horn'],
    ['kissed', 'maiden all forlorn'],
    ['married', 'man all tattered and torn'],
    ['woke', 'priest all shaven and shorn'],
    ['kept', 'rooster that crowed in the morn'],
    ['belonged to', 'farmer sowing his corn'],
    ['', 'horse and the hound and the horn']
  ]
  def self.verse(verse_num, start)
    verb, noun = @word_pairs[verse_num]
    "#{start ? 'This is' : "that #{verb}"} the " \
      "#{noun}#{verse_num.zero? ? '' : "\n#{verse(verse_num - 1, false)}"}"
  end

  def self.recite
    (0..@word_pairs.length - 1).collect { |n| verse(n, true) }
                               .join("\n")
  end
end
