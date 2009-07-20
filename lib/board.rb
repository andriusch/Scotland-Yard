class Board < Gosu::Image
  def initialize(window)
    super(window, "data/map.png", true)
    @scalex = LEFT_PANEL_X.to_f / self.width
    @scaley = window.height.to_f / self.height
    @window = window

    @config = YAML.load(IO.read("data/config.yml"))
    puts @config.inspect
    @config['starting'].shuffle!
    @mr_x = Player.new(window, 'Mr. X', 0x22aaaaaa, @config['starting'].shift)
    @detectives = @config['detectives'].keys.collect {|k| Player.new(window, k, @config['detectives'][k]['color'], @config['starting'].shift) }
    @current_player_id = 0

    load_coords
    @routes = Routes.new('data/SCOTMAP.TXT')
  end

  def draw
    super(0, 0, 0, @scalex, @scaley)
    @detectives.each {|d| draw_player(d)}
    draw_player(@mr_x)
  end

  def current_player
    @current_player_id == 0 ? @mr_x : @detectives[@current_player_id - 1]
  end

  def current_player_name
    @current_player_id == 0 ? 'Mr. X' : "Detective #{@current_player_id}"
  end

  def current_player_goto(x, y)
    cell = cell_from_xy(x, y)
    cur_player = current_player
    if cell and @routes[cur_player.cell, cell]
      @window.logger.log("#{current_player_name} - #{@routes.to_s(cur_player.cell, cell)}")
      cur_player.cell = cell
      next_player
    end
  end

  def next_player
    @current_player_id = (@current_player_id + 1) % (@detectives.size + 1)
    puts @current_player_id
  end

  protected

  def cell_from_xy(x, y)
    cell = @coords.index {|c| ((x - 8)..(x + 8)).include?(c[:x] * @scalex) and ((y - 8)..(y + 8)).include?(c[:y] * @scaley)}
    cell + 1 if cell
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
end