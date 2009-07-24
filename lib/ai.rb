class AI
  def self.mr_x_move(cell, tickets, detective_cells, doubles)
    routes = Routes.instance.moves(cell, tickets, detective_cells)
    data = {}

    routes.each do |r, route|
      data[r] = {}
      data[r][:dist] = detective_cells.collect do |d|
        dist = Routes.instance.distance(r, d)
        dist < 3 ? (dist - 2.5) * 3 : dist ** 0.5
      end
      data[r][:points] = data[r][:dist].reduce(:+) + route.size
      data[r][:points] -= route.size * -5 if route.size < 3
    end

    best = nil
    data.each {|r, dist| best = r if best.nil? or data[best][:points] < dist[:points]}
    puts data.inspect
    puts best.inspect

    trans = Routes.instance.best_transport(cell, best)

    return best, trans, (data[best][:points] < 8 and doubles > 0 and data[best][:dist].include?(-4.5))
  end

  def self.detective_move
    
  end
end