class Bob
  def self.hey(prompt)
    prompt = prompt.strip
    if prompt == ''
      'Fine. Be that way!'
    elsif prompt =~ /[A-Z]/ && prompt.upcase == prompt
      'Whoa, chill out!'
    elsif prompt[-1] == '?'
      'Sure.'
    else
      'Whatever.'
    end
  end
end
