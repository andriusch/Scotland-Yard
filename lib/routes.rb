class Routes
  NAMES = {'T' => 'Taxi', 'B' => 'Bus', 'U' => 'U.G.', 'X' => 'Unknown'}
  include Singleton

  def initialize
    @routes = {}
    @distances = []
    IO.readlines('data/routes.txt').each do |line|
      line =~ /(\d+)\s+(\d+)\s+([TBU])/
      a, b = $1.to_i, $2.to_i
      add_route(a, b, $3)
      add_route(b, a, $3)
      @distances[a] ||= []
      @distances[b] ||= []
      if detective_route?(a, b)
        set_distance(a, b, 1)
        set_distance(b, a, 1)
      end
    end

    @distances.each_index do |d|
      set_distance(d, d, 0)
      set_distances(d)
    end
  end

  def [](from, to = nil)
    to ? @routes[from][to] : @routes[from]
  end

  def all_from(from, tickets, occupied)
    all = []
    moves(from, tickets, occupied).each do |to, trans|
      trans.each {|t| all << "#{Routes.name(t)} to #{to}" }
    end
    all.join("\n")
  end

  def moves(from, tickets, occupied)
    @routes[from].reject {|r, trans| occupied.include?(r) or trans.all?{|t| tickets[t] <= 0 } }
  end

  def self.name(transport)
    NAMES[transport]
  end

  def distance(from, to)
    @distances[from][to]
  end

  def best_transport(from, to)
    trans = if @routes[from][to].include?('T')
      'T'
    elsif @routes[from][to].include?('B')
      'B'
    elsif @routes[from][to].include?('U')
      'U'
    else
      'X'
    end
  end

  protected

  def detective_route?(from, to)
    trans = @routes[from][to]
    trans.size > 1 or !trans.include?('X')
  end

  def add_route(from, to, by)
    @routes[from] ||= {}
    @routes[from][to] ||= Set.new
    @routes[from][to] << by
  end

  def set_distance(from, to, distance)
    if (@distances[from][to].nil? or @distances[from][to] > distance)
      @distances[from][to] = distance
      return true
    end
  end

  def set_distances(from)
    queue = @routes[from].keys
    while queue.size > 0
      start = queue.shift
      @routes[start].each do |r, trans|
        if detective_route?(start, r)
          queue << r if set_distance(from, r, @distances[from][start] + 1)
        else
          puts trans.inspect
        end
      end
    end
  end
end