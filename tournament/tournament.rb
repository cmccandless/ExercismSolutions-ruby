class Tournament
  def self.flip_result(result)
    case result
    when 'win'
      'loss'
    when 'loss'
      'win'
    else
      result
    end
  end

  def self.apply_game(game, teams)
    home, away, result = game.split(';')
    [home, away].each do |team|
      teams[team] = Team.new(team) unless teams.key?(team)
    end
    teams[home] += result
    teams[away] += flip_result(result)
  end

  def self.tally(games)
    games.split("\n")
         .each_with_object({}, &method(:apply_game))
         .values
         .sort
         .collect(&:to_s)
         .unshift("#{'Team'.ljust(31)}| MP |  W |  D |  L |  P\n")
         .join
  end
end
class Team
  attr_reader :name, :points
  def initialize(name, games = [0, 0, 0])
    @name = name
    @games = games
    @points = games.zip([3, 1, 0]).collect { |g, m| g * m }.reduce(0, :+)
  end

  def +(other)
    inc = (case other
           when 'win'
             '100'
           when 'draw'
             '010'
           when 'loss'
             '001'
           end).chars
          .collect(&:to_i)
    Team.new(name, @games.zip(inc).collect { |x| x.reduce(0, :+) })
  end

  def <=>(other)
    c = other.points <=> points
    c.zero? ? name <=> other.name : c
  end

  def to_s
    [@games.reduce(0, :+),
     @games[0],
     @games[1],
     @games[2],
     points].collect { |x| x.to_s.rjust(3) }
      .unshift(name.ljust(30))
      .join(' |') + "\n"
  end
end
