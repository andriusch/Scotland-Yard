class GameWindow < Gosu::Window
  attr_reader :status, :logger

  def initialize
    super(1024, 768, false)
    self.caption = "Scotland Yard"

    @forms = []
    @f = TransportForm.new(self, 0, 0, 20, 80, 0)
    @f.taxi.on_click { @board.make_last_move('T') }
    @f.bus.on_click { @board.make_last_move('B') }
    @f.ug.on_click { @board.make_last_move('U') }

    @mrx_form = Form.new(self, 0, 0, 90, self.width, self.height)
    @mrx_form.add_component(button = Clickable.new(self, 450, 350, 'mrxmove'))
    button.on_click { @board.mrx_move }

    @win_form = WinForm.new(self, 0, 0, 99, self.width, self.height)
    @win_form.on_click { self.reset }
    
    @logger = Log.new(self)
    @cursor = Cursor.new(self)
    @status = Status.new(self)
    @board = Board.new(self)
  end

  def start_mrx_move
    @mrx_form.show
  end

  def gameover(detective_win)
    @win_form.show(detective_win)
  end

  def button_up(button)
    case button
      when Gosu::MsLeft:
        x, y = mouse_x, mouse_y
        ind = @forms.index{|c| c.clicked?(x, y) }
        if ind
          @forms[ind].click(x, y)
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
    @forms << clickable
    @forms.sort {|a, b| a.z <=> b.z}
  end

  def reset
    @board.reset
    @logger.reset
  end

  def update

  end

  def draw
    @board.draw
    @logger.draw
    @status.draw
    @cursor.draw
    @forms.each {|c| c.draw }
  end
end