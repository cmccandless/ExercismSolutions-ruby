class ETL
  def self.transform(input)
    input.to_a.flat_map { |p| p[1].collect { |v| [v.downcase, p[0]] } }.to_h
  end
end
module BookKeeping
  VERSION = 1 # Where the version number matches the one in the test.
end
