class Bob
  @silent = 4
  @yell_ask = 3
  @yell = 2
  @ask = 1
  @none = 0

  def self.question?(prompt)
    prompt.end_with?('?') ? @ask : @none
  end

  def self.yelling?(prompt)
    prompt !~ /[a-z]/ && prompt =~ /[A-Z]/ ? @yell : @none
  end

  def self.encode(prompt)
    return @silent if prompt.empty?

    yelling?(prompt) | question?(prompt)
  end

  def self.hey(prompt)
    {
      @silent => 'Fine. Be that way!',
      @yell_ask => "Calm down, I know what I'm doing!",
      @yell => 'Whoa, chill out!',
      @ask => 'Sure.',
      @none => 'Whatever.'
    }[encode(prompt.strip)]
  end
end
