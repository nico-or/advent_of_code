require_relative "assigment"

input = File.read("./input.txt")

pairs = input.lines.map do |line|
  line.chomp.split(",").map do |assigment|
    Assigment.new(assigment)
  end
end

pairs.count do |first, second|
  first.fully_contain?(second) || second.fully_contain?(first)
end.tap { puts "Count of assigment pairs where one is fully contained: #{_1}" }
