class Board < Gosu::Image
  def initialize(window)
    super(window, "data/map.png", true)
    @scalex = LEFT_PANEL_X.to_f / self.width
    @scaley = window.height.to_f / self.height
    @window = window

    @config = YAML.load(IO.read("data/config.yml"))
    @coords = Coords.new(@scalex, @scaley)
    @routes = Routes.new('data/routes.txt')
    reset
  end

  def reset
    starting = @config['starting'].shuffle
    @mr_x = Criminal.new(window, 'Mr. X', 0x22aaaaaa, starting.shift)
    @detectives = @config['detectives'].collect {|d| Player.new(window, d['name'], d['color'], starting.shift) }

    @current_player_id = @detectives.size
    next_player
  end

  def draw
    super(0, 0, 0, @scalex, @scaley)
    @detectives.each {|d| draw_player(d)}
    draw_player(@mr_x) if @mr_x.visible
  end

  def current_player
    @current_player_id == 0 ? @mr_x : @detectives[@current_player_id - 1]
  end

  def current_player_goto(x, y)
    cell = @coords.cell_from_xy(x, y)
    cur_player = current_player
    route = @routes[cur_player.cell, cell]
    if cell and route
      if route.size == 1
        cur_player.move(cell, route.first)
        next_player
        return nil
      else
        @last_move = cell
        return route
      end
    end
  end

  def make_last_move(trans)
    current_player.move(@last_move, trans)
    next_player
  end

  def next_player
    @current_player_id = @current_player_id + 1
    if @current_player_id > @detectives.size
      @window.start_mrx_move
    else
      set_status
    end
  end

  def mrx_move
    @current_player_id = 0
    set_status
  end

  protected

  def set_status
    @window.status.set("#{current_player.name} move (#{current_player.cell})\n" + @routes.all_from(current_player.cell))
  end

  def draw_player(p)
    c = @coords[p.cell - 1]
    p.draw(c[:x] * @scalex - 12, c[:y] * @scaley - 12)
  end
end