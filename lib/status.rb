class Status
  def initialize(window)
    @font = Gosu::Font.new(window, 'Sans', 16)
    @x = LEFT_PANEL_X
    @y = STATUS_Y
    @lines = []
  end

  def set(message)
    @lines = message.split("\n")
  end

  def draw
    @lines.take(10).each_with_index do |line, i|
      @font.draw(line, @x + 2, @y + i * 16 + 2, 0)
    end
  end
end