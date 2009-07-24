class Coords
  include Singleton

  attr_accessor :scalex, :scaley

  def initialize
    @coords = IO.readlines('data/coords.txt').collect do |line|
      line =~ /(\d+)\s*,\s*(\d+)/
      {:x => $1.to_i, :y => $2.to_i}
    end
  end

  def cells
    (1..@coords.size).to_a
  end

  def [](value)
    c = @coords[value].clone
    c[:x] *= @scalex
    c[:y] *= @scaley
    c
  end

  def cell_from_xy(x, y)
    cell = @coords.index {|c| ((x - 8)..(x + 8)).include?(c[:x] * @scalex) and ((y - 8)..(y + 8)).include?(c[:y] * @scaley)}
    cell + 1 if cell
  end
end