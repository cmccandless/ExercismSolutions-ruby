class Game
  class BowlingError < StandardError
    def initialize(msg = '') end
  end

  def initialize(num = 1)
    @num = num
    @ball1 = nil
    @ball2 = nil
    @next = nil
  end

  def balls
    return [] unless @ball1

    return [@ball1] unless @ball2

    [@ball1, @ball2]
  end

  def strike?
    @ball1 && @ball1 == 10
  end

  def spare?
    !strike? && @ball2 && balls.reduce(0, :+) == 10
  end

  def valid_pins?(pins, ball = 1)
    case ball
    when 1
      pins >= 0 && pins <= 10
    when 2
      pins + @ball1 <= 10
    end
  end

  def can_roll?
    if @num < 10
      true
    elsif strike?
      @next.nil? || @next.balls.length < 2
    elsif spare?
      @next.nil? || @next.balls.empty?
    end
  end

  def roll_next_frame(pins)
    raise BowlingError unless can_roll?

    @next ||= Game.new(@num + 1)
    @next.roll(pins)
  end

  def roll(pins)
    raise BowlingError unless valid_pins?(pins)

    if @ball1.nil?
      @ball1 = pins
    elsif !strike? && @ball2.nil?
      raise BowlingError unless valid_pins?(pins, 2)

      @ball2 = pins
    else
      roll_next_frame(pins)
    end
  end

  def rolls
    r = @next ? @next.rolls : []
    if @num < 10
      if strike?
        r = r.take(2) + r
      elsif spare?
        r = r.take(1) + r
      end
    end
    balls + r
  end

  def frames
    @next ? [self] + @next.frames : [self]
  end

  def complete_10th?
    !frames[-1].strike? && !frames[-1].spare?
  end

  def complete_11th?
    !frames[-2].strike? || frames[-1].balls.length >= 2
  end

  def complete?
    case frames.length
    when 0..9
      false
    when 10
      complete_10th?
    when 11
      complete_11th?
    when 12
      true
    end
  end

  def score
    raise BowlingError unless complete?

    rolls.reduce(0, :+)
  end

  def to_s
    "{num: #{@num}, balls: #{balls}, next=\n#{@next}}"
  end
end
