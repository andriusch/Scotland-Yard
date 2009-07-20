class GameWindow < Gosu::Window
  attr_reader :status, :logger, :board

  def initialize
    super(1024, 768, false)
    self.caption = "Scotland Yard"
    @logger = Log.new(self)
    @cursor = Cursor.new(self)
    @status = Status.new(self)
    @board = Board.new(self)

    @clickables = []
    @f = TransportForm.new(self, 0, 0, 20, 80, 0)
  end

  def button_up(button)
    case button
      when Gosu::MsLeft:
        x, y = mouse_x, mouse_y
        ind = @clickables.index{|c| puts c.clicked?(x, y); c.clicked?(x, y) }
        if ind
          @clickables[ind].click(x, y)
        elsif mouse_x < LEFT_PANEL_X
          if t = @board.current_player_goto(x, y)
            @f.top = y
            @f.left = x
            @f.show(t)
          end
        end
    end
  end

  def register_clickable(clickable)
    @clickables << clickable
    @clickables.sort {|a, b| a.z <=> b.z}
  end

  def update

  end

  def draw
    @board.draw
    @logger.draw
    @status.draw
    @cursor.draw
    @f.draw
  end
end