# frozen_string_literal: true

require 'matrix'

filename = ARGV[0]

input = File.read(filename).lines(chomp: true)
L_REGEX = /\[(.+)\] (\(.+\)) (\{.+\})/.freeze

machines = input.map do |line|
  m = L_REGEX.match(line)
  n_light = m[1].size

  target_binary = m[1].gsub(/[\.#]/,{'.'=>0,'#'=>1}).to_i(2)

  button_array = m[2].split.map do |button_line|
    row = Array.new(n_light, 0)
    button_line.scan(/\d+/) { |idx| row[idx.to_i] = 1 }
    row.join.to_i(2)
  end

  [target_binary,button_array]
end

counts = machines.map do |machine|
  light_target = machine[0]
  buttons = machine[1]

  queue = Queue.new
  queue << {state: 0, count: 0}
  
  visited = Set.new
  
  loop do
    queue.pop => {state:, count:}
    
    next if visited.include? state
    visited << state

    break count if state == light_target

    buttons.each do |mask|
      new_state = state ^ mask
      queue << {state: new_state, count: count + 1 }
    end
  end
end

p counts.sum
