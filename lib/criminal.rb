class Criminal < Player
  SHOW_ON = [3, 8, 13, 18, 23]
  attr_writer :visible

  def move_text(cell, transport)
    text = "#{@name} - #{Routes.name(transport)}"
    text += " #{cell}" if SHOW_ON.include?(@moves.size)
    text
  end

  def visible
    @visible or SHOW_ON.include?(@moves.size)
  end
end