class Detective < Player
  def move(cell, transport)
    super
    @board.mr_x.set_impossible(cell)
  end
end