require_relative "lib/graph"
require_relative "lib/map"
require_relative "lib/min_priority_queue"

#filename = "./spec/fixtures/input.txt"
filename = "input.txt"

map = Map.from_file(filename)
puts map

def reconstruct_path(previous, end_index)
  path = [end_index]
  until previous[path.last].nil?
    path << previous[path.last]
  end
  path.reverse
end

def DJ_search(map, start_index, end_index)
  distances = Array.new(map.vertex_count) { Float::INFINITY }
  previous = Array.new(map.vertex_count)

  distances[start_index] = 0

  vertex_queue = MinPriorityQueue.new
  vertex_queue.push(start_index, 0)

  until vertex_queue.empty?
    current_index = vertex_queue.pop
    current_distance = distances[current_index]

    return reconstruct_path(previous, end_index) if current_index.eql? end_index

    adj = map.adj(current_index).shuffle

    adj.each do |next_index|
      new_dist = current_distance + 1
      if new_dist < distances[next_index]
        distances[next_index] = new_dist
        previous[next_index] = current_index
        vertex_queue.push(next_index, new_dist)
      end
    end
  end
end

puts "Dijkastra solution"
path = DJ_search(map, map.start_index, map.end_index)
puts "steps: #{path.length - 1}"

puts map.draw_path(path)

#part 2
start_indexes = map.find_all("a")
paths = start_indexes.map { |start_index| DJ_search(map, start_index, map.end_index) }.compact
shortest_path = paths.min_by(&:length)

puts map.draw_path(path)
puts "steps: #{shortest_path.length - 1}"
