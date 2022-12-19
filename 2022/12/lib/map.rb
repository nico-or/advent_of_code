class Map
  def self.from_file(filename)
    input = File.readlines(filename, chomp: true)

    Map.new(
      input.count,
      input.first.length,
      input.join
    )
  end

  def initialize(rows, cols, string)
    @row_count = rows
    @col_count = cols
    @total_count = @row_count * @col_count
    @chars = string.chars

    @graph = build_graph
  end

  def vertex_count
    @total_count
  end

  def to_s
    @chars
      .each_slice(@col_count)
      .to_a
      .map(&:join)
      .join("\n")
  end

  def start_index
    find_char("S")
  end

  def end_index
    find_char("E")
  end

  def adj(index)
    @graph.adj(index)
  end

  def draw_path(path)
    foo = @chars.dup
    path[1..-2].each { foo[_1] = "\u2059" }

    foo
      .each_slice(@col_count)
      .to_a
      .map(&:join)
      .join("\n")
  end

  def find_all(input)
    @chars.filter_map.with_index { |char, idx| idx if char.eql? input }
  end

  private

  def find_char(char)
    @chars.find_index(char)
  end

  def height(char)
    return "a".ord if char.eql? "S"
    return "z".ord if char.eql? "E"

    char.ord
  end

  def connected?(from, to)
    height(@chars[to]) - height(@chars[from]) <= 1
  end

  def adjacent_indexes(index)
    return [] unless (0...@total_count).include?(index)

    [
      index + 1,
      index - 1,
      index + @col_count,
      index - @col_count,
    ].select { (0...@total_count).include? _1 }
  end

  def position_to_index(position)
    row, col = position
    col + row * @col_count
  end

  def index_to_position(index)
    row, col = index.divmod @col_count
  end

  def build_graph
    graph = Graph.new(@row_count * @col_count)
    @chars.each.with_index do |char, index|
      adj = adjacent_indexes(index).select { connected?(index, _1) }
      adj.each { graph.add_edge(index, _1) }
    end
    graph
  end
end
