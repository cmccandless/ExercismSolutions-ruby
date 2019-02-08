class Anagram
  def initialize(base_word)
    @base_word = base_word
  end

  def match(words)
    sorted = @base_word.downcase.chars.sort
    words.select do |w|
      !w.casecmp(@base_word).zero? && w.downcase.chars.sort == sorted
    end
  end
end
