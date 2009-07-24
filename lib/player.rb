class Player < Gosu::Image
  attr_accessor :cell, :board
  attr_reader :name, :tickets

  def initialize(window, board, name, color, starting_cell)
    super(window, "data/player.png", false)
    @color = 0x99000000 + color
    @cell = starting_cell
    @name = name
    @window = window
    @moves = []
    @board = board
    create_tickets
  end

  def create_tickets
    @tickets = {'T' => 10, 'B' => 8, 'U' => 4, 'X' => 0}
  end

  def move(cell, transport)
    @moves << cell
    take_ticket(transport)
    @window.logger.log(move_text(cell, transport))
    @cell = cell
  end

  def move_text(cell, transport)
    "#{@name} - #{Routes.name(transport)} #{cell}"
  end

  def take_ticket(type)
    @tickets[type] -= 1
  end

  def tickets_string
    @tickets.keys.select {|t| @tickets[t] > 0 }.collect {|t| "#{Routes.name(t)}: #{@tickets[t]}" }.join("\n")
  end

  def draw(x, y)
    super(x, y, 10, 1, 1, @color)
  end
end