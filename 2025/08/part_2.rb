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
group_id = 0
last = nil

distances.each do |(i,j,_d)|
  next unless [groups[i], groups[j]].any?(&:nil?)

  graph[i] << j
  graph[j] << i

  queue = [i,j]
  visited = Set.new

  until queue.empty?
    c = queue.pop
    visited << c
    
    groups[c] = group_id
    graph[c].each { |p| queue << p unless visited.include?(p) }
  end

  group_id += 1
  last = [i,j]

  # everything in a single group
  break if groups.none?(&:nil?)
end

p last
p a = points[last[0]]
p b = points[last[1]]
p a.x * b.x