class Form
  attr_accessor :left, :top, :z, :width, :height, :visible

  include Component

  def initialize(window, x, y, z, width, height)
    @left, @top, @z = x, y, z
    @width, @height = width, height
    @components = []
    @window = window
    @window.register_clickable(self)
  end

  def add_component(component)
    @components << component
    component.visible = true
  end

  def click(x, y)
    clicked = @components.select {|c| c.clicked?(x - self.left, y - self.top) }
    clicked.each {|c| c.click }
    hide unless clicked.empty?
  end

  def draw
    @components.each {|c| c.draw(left + c.left, top + c.top, z) if c.visible } if visible
  end
end