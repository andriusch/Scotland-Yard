class Routes
  NAMES = {'T' => 'Taxi', 'B' => 'Bus', 'U' => 'U.G.'}

  def initialize(file_name)
    @routes = {}
    IO.readlines(file_name).each do |line|
      line =~ /(\d+)\s+(\d+)\s+([TBU])/
      add_route($1.to_i, $2.to_i, $3)
      add_route($2.to_i, $1.to_i, $3)
    end
  end

  def [](from, to = nil)
    to ? @routes[from][to] : @routes[from]
  end

  def all_from(from)
    all = []
    @routes[from].each do |to, trans|
      trans.each {|t| all << "#{Routes.name(t)} to #{to}"}
    end
    all.join("\n")
  end

  def self.name(transport)
    NAMES[transport]
  end

  protected

  def add_route(from, to, by)
    @routes[from] ||= {}
    @routes[from][to] ||= Set.new
    @routes[from][to] << by
  end
end