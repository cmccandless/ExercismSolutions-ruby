class Acronym
  def self.abbreviate(phrase)
    phrase.tr(':,', '')
          .tr('-', ' ')
          .split(' ')
          .collect { |word|
            word[0]
          }
          .join
          .upcase
  end
end
