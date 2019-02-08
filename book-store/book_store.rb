class BookStore
  @base_cost = 8
  def self.get_group_count(books)
    books.uniq.map { |b| books.count(b) }.max
  end

  def self.get_groupings(books)
    num_groups = get_group_count(books)
    initial = [Grouping.start(books.shift)]
    books.reduce(initial) do |groupings, book|
      groupings.flat_map { |gs| gs.add_to_all(book) }
               .reject { |g| g.length > num_groups }
    end
  end

  def self.calculate_price(books)
    return 0 if books.empty?

    @base_cost * get_groupings(books.sort)
                 .min
                 .total
  end
end

class Grouping
  attr_accessor :groups
  def self.start(book)
    Grouping.new([[book]])
  end

  def initialize(groups)
    @groups = groups
    @discount = [1.0, 1.0, 0.95, 0.9, 0.8, 0.75]
  end

  def total
    groups.collect { |g| g.size * @discount[g.size] }.reduce(0, :+)
  end

  def dup
    Grouping.new(groups.collect(&:dup))
  end

  def add_to_all(book)
    other = dup
    other.groups.push([book])
    groups.each_with_index
          .reject { |group, _| group.include?(book) }
          .collect { |_, i|
            o = dup
            o.groups[i].push(book)
            o
          }.push(other)
  end

  def <=>(other)
    total <=> other.total
  end

  def length
    groups.length
  end
end
