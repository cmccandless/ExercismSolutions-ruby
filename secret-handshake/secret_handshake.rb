class SecretHandshake
  def initialize(code)
    @codes = ['wink', 'double blink', 'close your eyes', 'jump']
    @code = code
  end

  def bit_set?(bit)
    !(@code & (1 << bit)).zero?
  end

  def commands
    return [] unless @code.is_a?(Integer)

    cmds = @codes.each_with_index
                 .select { |_, i| bit_set?(i) }
                 .collect(&:first)
    cmds.reverse! if bit_set?(@codes.length)
    cmds
  end
end
