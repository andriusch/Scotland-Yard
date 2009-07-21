class Clickable < Gosu::Image
  attr_accessor :visible, :left, :top

  include Component

  def initialize(window, x, y, image)
    super(window, "data/#{image}.png", false)
    @window = window
    @left = x
    @top = y
  end

  def on_click(&block)
    @on_click = block 
  end

  def click
    @on_click.call if @on_click
  end
end