class Coords
  def intialize(scalex, scaley)
    @coords = IO.readlines('data/COORDS.TXT').collect do |line|
      line =~ /(\d+)\s*,\s*(\d+)/
      {:x => $1.to_i * scalex, :y => $2.to_i * scaley}
    end
  end

  def [](value)
    @coords[value]
  end

  def cell_from_xy(x, y)
    cell = @coords.index {|c| ((x - 8)..(x + 8)).include?(c[:x]) and ((y - 8)..(y + 8)).include?(c[:y])}
    cell + 1 if cell
  end
end