class Clock
  attr_reader :minutes
  def initialize(params)
    @minutes = 0
    @minutes += params[:hour] * 60 unless params[:hour].nil?
    @minutes += params[:minute] unless params[:minute].nil?
    @minutes += 1440 while @minutes < 0
    @minutes %= 1440
  end

  def self.at(hour, min)
    Clock.new(min, hour)
  end

  def to_s
    h = (minutes / 60).to_s.rjust(2, '0')
    m = (minutes % 60).to_s.rjust(2, '0')
    "#{h}:#{m}"
  end

  def +(other)
    Clock.new(minute: minutes + other.minutes)
  end

  def -(other)
    Clock.new(minute: minutes - other.minutes)
  end

  def ==(other)
    to_s == other.to_s
  end
end
