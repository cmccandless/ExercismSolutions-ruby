class HighScores
  attr_reader :scores
  def initialize(scores)
    @scores = scores
  end

  def latest
    @scores[-1]
  end

  def personal_best
    @scores.max
  end

  def personal_top
    @scores.sort.reverse.take(3)
  end

  def report
    diff = personal_best - latest
    msg = "Your latest score was #{latest}. That's "
    msg += "#{diff} short of " unless diff.zero?
    msg + 'your personal best!'
  end
end
