class Board < Gosu::Image
  def initialize(window)
    super(window, "data/map.png", true)
    @scalex = (window.width - 100).to_f / self.width
    @scaley = window.height.to_f / self.height
    @detectives = [[0xaa00ff, 10], [0xff0000, 111], [0x00ff00, 73], [0xffff00, 17], [0x0000ff, 183]].collect {|c| Player.new(window, c[0], c[1]) }
    @mr_x = Player.new(window, 0xdddddd, 45)

    load_coords
  end

  def draw
    super(0, 0, 0, @scalex, @scaley)
    @detectives.each {|d| draw_player(d)}
    draw_player(@mr_x)
  end

  protected

  def draw_player(p)
    c = @coords[p.cell - 1]
    p.draw(c[:x] * @scalex - 12, c[:y] * @scaley - 12)
  end

  def load_coords
    @coords ||= IO.readlines('data/COORDS.TXT').collect do |line|
      line =~ /(\d+)\s*,\s*(\d+)/
      {:x => $1.to_i, :y => $2.to_i}
    end
  end
end