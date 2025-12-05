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
  curr_pos = (curr_pos + move).modulo(POS_COUNT)
  password += 1 if curr_pos.zero?
end

puts password