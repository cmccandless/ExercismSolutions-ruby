class Array
  def extract_modulus(indices, mod, offset = 0)
    drop(offset).each_with_index.each_with_object([]) do |pair, result|
      value, index = *pair
      result.push(value) if indices.include?(index % mod)
    end
  end
end

class String
  def extract_modulus(indices, mod, offset = 0)
    chars.extract_modulus(indices, mod, offset)
  end
end

class RailFenceCipher
  def self.get_rails(str, n_rails)
    mod = n_rails * 2 - 2
    Array.new(n_rails) do |rail_index|
      indices = [rail_index, 2 * (n_rails - 1) - rail_index]
                .uniq
                .reject { |i| i >= mod }
      str.extract_modulus(indices, mod).join
    end
  end

  def self.encode(str, n_rails)
    return str if n_rails < 2

    get_rails(str, n_rails).join
  end

  def self.distribute_rails(rails)
    rails += rails[1..-2].reverse if rails.length > 2

    decoded = ''
    until rails.empty?
      rail = rails.shift
      decoded += rail.shift unless rail.empty?
      rails.push(rail) unless rail.empty?
    end
    decoded
  end

  def self.decode(str, n_rails)
    return str if (n_rails < 2) || str.empty?

    chars = str.chars
    rails = get_rails(str, n_rails)
            .map(&:length)
            .map(&chars.method(:shift))
    distribute_rails(rails)
  end
end
