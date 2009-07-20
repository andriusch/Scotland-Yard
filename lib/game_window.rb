class GameWindow < Gosu::Window
  def initialize
    super(1024, 768, false)
    self.caption = "Scotland Yard"
    @board = Board.new(self)
  end

  def update
  end

  def draw
    @board.draw
  end
end