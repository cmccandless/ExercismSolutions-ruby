class Dominoes
  def self.valid_chain?(chain)
    chain && chain[0][0] == chain[-1][1]
  end

  def self.merge_left_left(chain, domino)
    return unless chain.size == 1 && chain[0][0] == domino[0]

    chain[0].reverse!
    chain.push(domino)
  end

  def self.merge_left_right(chain, domino)
    return unless chain.size == 1 && chain[0][0] == domino[1]

    chain[0].reverse!
    chain.push(domino.reverse)
  end

  def self.merge_right_left(chain, domino)
    return unless chain[-1][1] == domino[0]

    chain.push(domino)
  end

  def self.merge_right_right(chain, domino)
    return unless chain[-1][1] == domino[1]

    chain.push(domino.reverse)
  end

  def self.step(chain, domino)
    return nil if chain.nil?
    return chain if merge_left_left(chain, domino)
    return chain if merge_left_right(chain, domino)
    return chain if merge_right_left(chain, domino)
    return chain if merge_right_right(chain, domino)
  end

  def self.try_chain(permutation)
    permutation.reduce([permutation.shift], &method(:step))
  end

  def self.chain?(dominoes)
    return [] if dominoes.empty?

    dominoes.permutation
            .lazy
            .map(&method(:try_chain))
            .find(&method(:valid_chain?))
  end
end
