# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename).lines(chomp: true)

POINTS = input.map { |line| line.split(',').map(&:to_i) }

def dist(a, b)
  xa, ya = a
  xb, yb = b

  (xa - xb).abs + (ya - yb).abs
end

# sorting the edges gets time down from 6s to 2s
EDGES = (POINTS + [POINTS[0]]).each_cons(2).sort_by { |(a, b)| -1 * dist(a, b) }

def area(a, b)
  xa, ya = a
  xb, yb = b

  (1 + (xa - xb).abs) * (1 + (ya - yb).abs)
end

areas = POINTS.combination(2).map do |(a, b)|
  [a, b, area(a, b)]
end

areas.sort_by! { -1 * it.last }

def intersect(edge_a, edge_b)
  (x1a, y1a), (x2a, y2a) = edge_a
  (x1b, y1b), (x2b, y2b) = edge_b

  # check if edge are vertical
  a_vertical = (x1a == x2a)
  b_vertical = (x1b == x2b)

  return false if a_vertical == b_vertical

  if a_vertical
    x1a.between?(*[x1b, x2b].sort) && y1b.between?(*[y1a, y2a].sort)
  else
    x1b.between?(*[x1a, x2a].sort) && y1a.between?(*[y1b, y2b].sort)
  end
end

answer = areas.find do |area|
  (xa, ya), (xb, yb), = area

  xa, xb = [xa, xb].sort
  ya, yb = [ya, yb].sort

  inner_square = [
    [xa + 1, ya + 1],
    [xa + 1, yb - 1],
    [xb - 1, yb - 1],
    [xb - 1, ya + 1],
    [xa + 1, ya + 1]
  ]

  inner_edges = inner_square.each_cons(2)

  inner_edges.none? do |inner_edge|
    EDGES.any? do |polygon_edge|
      intersect(inner_edge, polygon_edge)
    end
  end
end

p answer.last
