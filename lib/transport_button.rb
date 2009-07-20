class TransportButton < Clickable
  def initialize(window, x, y, image, trans)
    super(window, x, y, image)
    @trans = trans
  end

  def click
    @window.board.make_last_move(@trans)
  end
end