class Poker
  def initialize(hand_strs)
    @hands = hand_strs.collect { |h| Hand.new(h) }
  end

  def keep_best(results, hand)
    case results[0] <=> hand
    when 0
      results.push(hand)
    when -1
      [hand]
    else
      results
    end
  end

  def best_hand
    (@hands[1..-1].reduce(@hands[0..0], &method(:keep_best)) || []).map(&:to_a)
  end
end

class Hand
  attr_reader :cards
  def initialize(cards)
    @cards = cards.collect { |card| Card.new(card) }
    @cards = @cards.collect(&:low_ace) if counts_s(0) == '145432'
  end

  def types
    %w[11111 2111 221 311 S F 32 41 SF]
  end

  def counts
    cs = @cards.collect(&:value)
               .group_by(&:itself)
               .collect { |value, group| [value, group.size] }
               .sort_by { |value, count| [-count, -value] }
    cs
  end

  def counts_s(index)
    counts.transpose[index].join
  end

  def low_straight_with_ace?(values)
    values[4] == 14 && values[0] == 2 && values[3] - values[0] == 3
  end

  def straight?
    values = counts.collect(&:first).sort
    values.size == 5 &&
      (values[4] - values[0] == 4 || low_straight_with_ace?(values))
  end

  def flush?
    @cards.collect(&:suit).group_by(&:itself).size == 1
  end

  def classify
    count_str = ''
    count_str = 'S' if straight?
    count_str += 'F' if flush?
    count_str = counts_s(1) if count_str.empty?
    types.index(count_str)
  end

  def <=>(other)
    c = classify <=> other.classify
    return c unless c.zero?

    counts.zip(other.counts)
          .collect { |a, b| a <=> b }
          .drop_while(&:zero?)
          .push(0)[0]
  end

  def to_a
    @cards.collect(&:to_s)
  end

  def to_s
    "[#{to_a.join(',')}]"
  end
end

class Card
  attr_reader :value
  attr_reader :suit
  def initialize(card_str)
    @value = card_str =~ /10/ ? 10 : values.index(card_str[0..-2])
    @suit = card_str[-1]
  end

  def values
    '_123456789TJQKA'
  end

  def <=>(other)
    c = @value <=> other.value
    return c unless c.zero?

    @suit <=> other.suit
  end

  def to_s
    case @value
    when 10
      "10#{@suit}"
    when 1
      "A#{@suit}"
    else
      "#{values[@value]}#{@suit}"
    end
  end

  def low_ace
    value == 14 ? Card.new("1#{suit}") : self
  end
end
