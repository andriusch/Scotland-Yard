class Board < Gosu::Image
  def initialize(window)
    super(window, "data/map.png", true)
    @scalex = LEFT_PANEL_X.to_f / self.width
    @scaley = window.height.to_f / self.height
    @detectives = [[0xaa00ff, 10], [0xff0000, 111], [0x00ff00, 73], [0xffff00, 17], [0x0000ff, 183]].collect {|c| Player.new(window, c[0], c[1]) }
    @mr_x = Player.new(window, 0xdddddd, 45)

    @current_player_id = 1

    load_coords
  end

  def draw
    super(0, 0, 0, @scalex, @scaley)
    @detectives.each {|d| draw_player(d)}
    draw_player(@mr_x)
  end

  def current_player
    @current_player_id == 0 ? @mr_x : @detectives[@current_player_id]
  end

  def current_player_goto(x, y)
    cell = cell_from_xy(x, y)
    puts "Go to #{cell.inspect}"
    current_player.cell = cell + 1 if cell
  end

  protected

  def cell_from_xy(x, y)
    @coords.index {|c| ((x - 8)..(x + 8)).include?(c[:x] * @scalex) and ((y - 8)..(y + 8)).include?(c[:y] * @scaley)}
  end

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

  def load_routes
    
  end
end