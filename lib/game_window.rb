class GameWindow < Gosu::Window
  def initialize
    super(1024, 768, false)
    self.caption = "Scotland Yard"
    @board = Board.new(self)
    @log = Log.new(self)
    @cursor = Cursor.new(self)
  end

  def logger
    @log
  end

  def button_up(button)
    case button
      when Gosu::MsLeft:
        if mouse_x < LEFT_PANEL_X
          @board.current_player_goto(mouse_x, mouse_y)
        end
    end
  end

  def update

  end

  def draw
    @board.draw
    @log.draw
    @cursor.draw
  end
end