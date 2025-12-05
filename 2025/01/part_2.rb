DIR_DICT = { 'L' => -1, 'R' => 1 }
START_POS = 50
POS_COUNT = 100

def parse_cmd(cmd)
  dir = cmd[0]
  num = cmd[1..]

  DIR_DICT.fetch(dir) * num.to_i
end

filename = ARGV[0]
input = File.readlines(filename, chomp: true)
moves = input.map { parse_cmd(it) }

curr_pos = START_POS
password = 0

moves.each do |move|
  
  old_pos = curr_pos
  new_pos = curr_pos + move 
  curr_pos = new_pos.modulo(POS_COUNT)
  
  laps = new_pos.div(POS_COUNT)

  password += laps.abs
  password += 1 if curr_pos.zero?

  # arrived at this by testing, but why?
  password -= 1 if curr_pos.zero? && new_pos >= 100
  password -= 1 if old_pos.zero? && move.negative? 
end

puts password
