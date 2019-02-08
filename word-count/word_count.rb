class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    @phrase.downcase
           .scan(/\w+(?:'t)?/)
           .each_with_object(Hash.new(0)) do |word, result|
      result[word] += 1 if word != ''
    end
  end
end
