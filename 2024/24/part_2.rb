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

output_keys = gates.keys.select { _1.start_with? 'z' }.sort

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

def save_graph(gates, filename)
  # save to grarphviz file to inspect
  File.open("#{filename}.dot",'w') do |f|
    f.puts "graph {"
    counter = 0
    (0..44).map { sprintf("x%02d", _1) }.then { f.puts "{#{_1.join(' ')}}" }
    (0..44).map { sprintf("y%02d", _1) }.then { f.puts "{#{_1.join(' ')}}" }

    %w[XOR AND OR].each do |type|
      curr_gates = gates.select { |out, (in_1, in_2, gate)| gate.eql? type }
      curr_gates.each do |out,(n_1,n_2,gate)|
        gate_name = sprintf("%s_%03d", gate, counter)
        counter += 1
        f.puts "#{gate_name}[shape=box]"
        f.puts "{#{[n_1, n_2].sort.join(' ')}} -- #{gate_name}"
        f.puts "#{gate_name} -- #{out}"
      end
    end
    
    f.write "}"
  end
  system("dot -T svg -o #{filename}.svg #{filename}.dot")
end

save_graph(gates, 'before')

swaps =[
  ['hwk', 'z06'],
  ['qmd', 'tnt'],
  ['hpc','z31'],
  ['cgr','z37'],
]

swaps.each do |at, to|
  gates[at], gates[to] = gates[to], gates[at]
end

# save_graph(gates,'after')

BIT_COUNT = 45
4.times do
  # generate 2 radom numbers
  x_val = (0..BIT_COUNT).each_with_object({}) { |idx, acc| acc[sprintf("x%02d", idx)] = idx.eql?(45) ? 0 : [0,1].sample }
  y_val = (0..BIT_COUNT).each_with_object({}) { |idx, acc| acc[sprintf("y%02d", idx)] = idx.eql?(45) ? 0 : [0,1].sample }
  
  # overwrite input values.
  values = x_val.merge(y_val)
  
  # the correct output
  x_int = x_val.values.join.reverse.to_i(2)
  y_int = y_val.values.join.reverse.to_i(2)
  target = (y_int + x_int).to_s(2)
  target_arr = target.reverse.chars.map(&:to_i)

  # current output 
  output_arr = output_keys.map { value(_1, values, gates) }
  
  # print the first index that doesn't match the expected output
  bad_idx = output_arr.zip(target_arr).find_index { |(a,b)| a != b }
  puts "bad_index at: #{bad_idx}"
end

puts swaps.flatten.sort.join(',')