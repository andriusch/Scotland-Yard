class TransportForm < Form
  attr_accessor :taxi, :bus, :ug

  def initialize(window, x, y, z, width, height)
    super
    @taxi = Clickable.new(window, 0, 0, 'taxi')
    @bus = Clickable.new(window, 0, 20, 'bus')
    @ug = Clickable.new(window, 0, 40, 'ug')
    add_component(@taxi)
    add_component(@bus)
    add_component(@ug)
  end

  def show(transports)
    ctop = 0
    ctop = toggle_button(@taxi, ctop, transports.include?('T'))
    ctop = toggle_button(@bus, ctop, transports.include?('B'))
    ctop = toggle_button(@ug, ctop, transports.include?('U'))
    self.height = top
    self.visible = true
  end

  def click(x, y)
    super
  end

  protected

  def toggle_button(button, top, visible)
    if visible
      button.top = top
      button.visible = true
      top += button.height
    else
      button.visible = false
    end
    top
  end
end