# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.read(FILENAME)

values, gates = input.split("\n\n")

values = values.lines
               .map { |line| /(.{3}): ([01])/.match(line).captures }
               .each_with_object({}) { |(name, val), acc| acc[name] = val.to_i }

gates = gates.lines
             .map { |line| /(.{3}) (AND|OR|XOR) (.{3}) -> (.{3})/.match(line).captures }
             .each_with_object({}) { |(n_1, gate, n_2, out), acc| acc[out] = [n_1, n_2, gate] }

output = gates.keys.select { _1.start_with? 'z' }

def value(name, values, gates)
  return values[name] if values.key? name

  name_1, name_2, gate = gates[name]
  case gate
  when 'AND'
    value(name_1, values, gates) & value(name_2, values, gates)
  when 'OR'
    value(name_1, values, gates) | value(name_2, values, gates)
  when 'XOR'
    value(name_1, values, gates) ^ value(name_2, values, gates)
  end
end

p output.sort.reverse.map { value(_1, values, gates) }.join.to_i(2)
