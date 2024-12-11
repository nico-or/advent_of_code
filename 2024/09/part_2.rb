# frozen_string_literal: true

filename = ARGV[0]

input = File.read(filename).chars.map(&:to_i)

counter = -1
memory = input.flat_map.with_index do |digit, index|
  case index % 2
  when 0
    counter += 1
    digit.times.map { counter }
  else
    digit.times.map { nil }
  end
end

r_end = memory.length - 1

catch(:end) do
loop do 
  # find next data block
  curr_char = nil
  r_end -= 1 while memory[r_end].nil?
  curr_char = memory[r_end]
  r_start = r_end
  r_start -= 1 while memory[r_start - 1].eql?(curr_char)
  r_size = r_end - r_start + 1
  throw(:end) if r_start < 0

  # find first valid empty block
  catch(:no_match) do
    l_size = r_size - 1
    l_start = 0
    loop do
      until memory[l_start].nil?
        l_start += 1
        throw(:no_match) if l_start >= r_start
      end
      l_end = l_start
      while memory[l_end + 1].nil?
        l_end += 1
        throw(:no_match) if l_end >= memory.length
      end 
      l_size = l_end - l_start + 1
      break if l_size >= r_size
      l_start = l_end + 1
    end
    
    # swap
    l_end = l_start + r_size - 1
    l_start.upto(l_end).each { memory[_1] = curr_char }
    r_start.upto(r_end).each { memory[_1] = nil }
    r_end = r_start- 1
    next
  end
  r_end = r_start- 1
end
end


p memory.map { _1.nil? ? 0 : _1 }
        .map.with_index { |v, i| v * i }
        .sum
