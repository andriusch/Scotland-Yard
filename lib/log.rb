class Log
  def initialize(window)
    @font = Gosu::Font.new(window, 'Sans', 16)
    @x = LEFT_PANEL_X
    @y = 0
    @lines = []
  end

  def log(message)
    @lines << message
  end

  def draw
    @lines.reverse.take(10).each_with_index do |line, i|
      @font.draw(line, @x + 2, @y + i * 16 + 2, 0)
    end
  end
end