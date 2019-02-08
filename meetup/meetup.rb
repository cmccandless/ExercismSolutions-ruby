require 'date'
class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  def n_to_day
    %i[sunday monday tuesday wednesday thursday friday saturday]
  end

  def ordinal
    %i[first second third fourth]
  end

  def apply_schedule_week(day, schedule)
    case schedule
    when :teenth
      day + 12
    when :last
      (day >> 1) - 7
    else
      day + 7 * ordinal.index(schedule)
    end
  end

  def day(day_of_week, schedule)
    d = Date.new(@year, @month, 1)
    d = apply_schedule_week(d, schedule)
    d += 1 while n_to_day[d.wday] != day_of_week
    d
  end
end
