# frozen_string_literal: true

Point = Data.define(:x, :y ,:z) do
  def inspect
    "#<Point (#{x},#{y},#{z})>"
  end  
end

def distance(a,b)
  Math.sqrt(
    (a.x - b.x)**2 + 
    (a.y - b.y)**2 + 
    (a.z - b.z)**2
  )
end


filename = ARGV[0]
N_CON = ARGV[1].to_i

input = File.read(filename).lines(chomp: true)

points = input.map { |line| Point.new(*line.split(',').map(&:to_i)) }

P_COUNT = points.length

distances = []

0.upto(P_COUNT-2).each do |i|
  (i+1).upto(P_COUNT-1).each do |j|
    a = points[i]
    b = points[j]

    distances << [i, j, distance(a,b)]
  end
end

distances.sort_by!(&:last)

graph = Hash.new { |h,k| h[k] = [] }
groups = P_COUNT.times.map { nil }

N_CON.times do |idx|
  i, j, _dist = distances[idx]

  graph[i]  << j
  graph[j]  << i

  queue = [i,j]
  visited = Set.new

  until queue.empty?
    curr = queue.pop
    visited << curr

    groups[curr] = idx
    graph[curr].each { queue << it unless visited.include?(it) }
  end
end

p groups.compact.tally.values.max(3).reduce(&:*)