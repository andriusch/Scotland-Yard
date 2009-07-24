class Board < Gosu::Image
  attr_reader :mr_x, :detectives

  def initialize(window)
    super(window, "data/map.png", true)
    @scalex = LEFT_PANEL_X.to_f / self.width
    @scaley = window.height.to_f / self.height
    @window = window

    @config = YAML.load(IO.read("data/config.yml"))
    Coords.instance.scalex, Coords.instance.scaley = @scalex, @scaley
    reset
  end

  def reset
    starting = @config['starting'].shuffle
    @mr_x = Criminal.new(@window, self, 'Mr. X', 0x22aaaaaa, starting.shift)
    @detectives = @config['detectives'].collect {|d| Detective.new(@window, self, d['name'], d['color'], starting.shift) }

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
    cell = Coords.instance.cell_from_xy(x, y)
    cur_player = current_player
    route = Routes.instance.moves(cur_player.cell, cur_player.tickets, detective_cells)[cell]

    if cell and route
      if route.size == 1
        cur_player.move(cell, route.first)
        next_player
        return nil
      elsif route.size > 1
        @last_move = cell
        return route
      else
        next_player
      end
    end
  end

  def make_last_move(trans)
    current_player.move(@last_move, trans)
    next_player
  end

  def next_player
    unless check_win
      @current_player_id = @current_player_id + 1
      if @current_player_id > @detectives.size
        @window.start_mrx_move
      else
        set_status
      end
    end
  end

  def mrx_move
    cell, trans, use_double = @mr_x.get_ai_move
    @mr_x.move(cell, trans)
    puts @mr_x.set_possible(trans).inspect
    if use_double
      @mr_x.take_double
      mrx_move
    end
    @current_player_id = 1
    set_status
  end

  def detective_cells
    @detectives.collect {|d| d.cell}
  end

  protected

  def check_win
    @detectives.each do |detective|
      if detective.cell == @mr_x.cell
        @window.gameover(true)
        return true
      end
    end
    return false
  end

  def set_status
    @window.status.set("#{current_player.name} move (#{current_player.cell})\n" + current_player.tickets_string + "\n" + 
            Routes.instance.all_from(current_player.cell, current_player.tickets, detective_cells))
  end

  def draw_player(p)
    c = Coords.instance[p.cell - 1]
    p.draw(c[:x] - 12, c[:y] - 12)
  end
end