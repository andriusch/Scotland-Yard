module Component
  def show
    @visible = true
  end

  def hide
    @visible = false
  end

  def right
    left + width
  end

  def bottom
    top + height
  end

  def clicked?(x, y)
    visible and (left..right).include?(x) and (top..bottom).include?(y)
  end
end