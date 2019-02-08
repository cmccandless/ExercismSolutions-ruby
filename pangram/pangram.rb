class Pangram
  def self.letter?(char)
    char =~ /[[:alpha:]]/
  end

  def self.pangram?(phrase)
    unique = phrase.downcase.chars.uniq
    return false if unique.nil?

    unique.select(&method(:letter?)).length == 26
  end
end
