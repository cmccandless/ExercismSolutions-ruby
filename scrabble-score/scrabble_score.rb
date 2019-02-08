class Scrabble
  def initialize(word)
    @word = word.nil? ? '' : word.downcase.tr('^a-z', '')
  end

  def scores
    {
      'aeioulnrst' => 1,
      'dg' => 2,
      'bcmp' => 3,
      'fhvwy' => 4,
      'k' => 5,
      'jx' => 8,
      'qz' => 10
    }
  end

  def score
    scores.collect { |letters, score| @word.count(letters) * score }
          .reduce(0, :+)
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end
