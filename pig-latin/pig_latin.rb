class PigLatin
  def self.consonents
    %w[sch squ thr qu th sc sh ch st rh] +
      'bcdfghjklmnpqrstvwxyz'.chars
  end

  def self.prefix(word)
    unless %w[xr yt].include?(word[0..1])
      consonents.each do |c|
        return [c, word[c.length..-1]] if word.start_with?(c)
      end
    end
    ['', word]
  end

  def self.translate(phrase)
    phrase.split(' ')
          .map(&method(:prefix))
          .map { |prefix, suffix| "#{suffix}#{prefix}ay" }
          .join(' ')
  end
end
