class Gigasecond
  def self.from(moment)
    Time.at(1_000_000_000 + moment.to_i)
  end
end
