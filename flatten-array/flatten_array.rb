class FlattenArray
  VERSION = 1

  def self.flatten(array)
    result = []
    array.each do |x|
      if x.is_a?(Array)
        result.concat(flatten(x))
      else
        result.push(x) unless x.nil?
      end
    end
    result
  end
end
