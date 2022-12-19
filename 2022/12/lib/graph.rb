class Graph
  def initialize(size)
    @adj_list = Array.new(size) { Array.new }
  end

  def add_edge(from, to)
    @adj_list[from] << to
  end

  def adj(from)
    @adj_list[from]
  end

  def adj?(from, to)
    @adj_list[from].include? to
  end

  def to_s
    @adj_list.map.with_index do |adj, idx|
      "[#{idx}] → #{adj}\n"
    end.join
  end
end
