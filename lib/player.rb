class Player < Gosu::Image
  attr_accessor :cell

  def initialize(window, name, color, starting_cell)
    super(window, "data/player.png", false)
    @color = 0x99000000 + color
    @cell = starting_cell
    @name = name
  end

  def draw(x, y)
    super(x, y, 10, 1, 1, @color)
  end
end