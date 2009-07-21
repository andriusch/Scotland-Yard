class WinForm < Form
  def initialize(window, x, y, z, width, height)
    super(window, x, y, z, width, height)
    add_component(@detective_win = Clickable.new(window, 350, 300, 'win_detectives'))
    add_component(@criminal_win = Clickable.new(window, 350, 300, 'win_criminal'))
  end

  def on_click(&block)
    @detective_win.on_click(&block)
    @criminal_win.on_click(&block)
  end

  def show(detectives_win)
    @detective_win.visible, @criminal_win.visible = if detectives_win
      [true, false]
    else
      [false, true]
    end
    super()
  end
end