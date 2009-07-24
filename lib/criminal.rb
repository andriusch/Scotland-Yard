class Criminal < Player
  SHOW_ON = [3, 8, 13, 18, 23]
  attr_writer :visible

  def initialize(window, board, name, color, starting_cell)
    super
    @doubles = 2
    @possible = Set.new()
  end

  def move_text(cell, transport)
    text = "#{@name} - #{Routes.name(transport)}"
    text += " #{cell}" if is_visible?
    text
  end

  def create_tickets
    @tickets = {'T' => 1.0 / 0, 'B' => 1.0 / 0, 'U' => 1.0 / 0, 'X' => 5}
  end

  def visible
    @visible or is_visible?
  end

  def set_possible(trans)
    @possible = get_possible(@possible, trans)
  end

  def get_possible(current, trans, cell = nil)
    if is_visible?
      puts "Visible"
      Set.new [cell || self.cell]
    else
      possible = Set.new
      detective_cells = board.detective_cells
      current.each do |c|
        Routes.instance[c].each do |to, transports|
          possible << to if transports.include?(trans) and !detective_cells.include?(to)
        end
      end
      possible
    end
  end

  def take_double
    @doubles -= 1
  end

  def set_impossible(cell)
    @possible.delete(cell)
  end

  def get_ai_move
    return AI.mr_x_move(cell, @tickets, board.detective_cells, @doubles)
  end

  protected

  def is_visible?(move = nil)
    SHOW_ON.include?(move || @moves.size)
  end
end