class Player < Gosu::Image
  attr_accessor :cell
  attr_reader :name

  def initialize(window, name, color, starting_cell)
    super(window, "data/player.png", false)
    @color = 0x99000000 + color
    @cell = starting_cell
    @name = name
    @window = window
    @moves = []
  end

  def move(cell, transport)
    @moves << cell
    @window.logger.log(move_text(cell, transport))
    @cell = cell
  end

  def move_text(cell, transport)
    "#{@name} - #{Routes.name(transport)} #{cell}"
  end

  def draw(x, y)
    super(x, y, 10, 1, 1, @color)
  end
end