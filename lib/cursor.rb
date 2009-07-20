class Cursor < Gosu::Image
  def initialize(window)
    super(window, 'data/cursor.png', false)
    @window = window
  end

  def set_coords(x, y)
    @x = x
    @x = 0 if @x < 0
    @x = @window.width if @x > @window.width

    @y = y
    @y = 0 if @y < 0
    @y = @window.height if @y > @window.height
  end

  def draw
    set_coords(@window.mouse_x, @window.mouse_y)
    super(@x, @y, 1000)
  end
end