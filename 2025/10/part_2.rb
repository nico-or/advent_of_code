# frozen_string_literal: true

# TODO: remove dependency
require 'glpk'

filename = ARGV[0]

input = File.read(filename).lines(chomp: true)
L_REGEX = /\[(.+)\] (\(.+\)) (\{.+\})/.freeze

machines = input.map do |line|
  m = L_REGEX.match(line)
  n_light = m[1].size

  button_array = m[2].split.map do |button_line|
    row = Array.new(n_light, 0)
    button_line.scan(/\d+/) { |idx| row[idx.to_i] = 1 }
    row
  end

  joltaje_target = m[3].scan(/\d+/).map(&:to_i)

  [joltaje_target, button_array]
end

sequences = machines.map do |machine|
  counter_target = machine[0]
  button_array = machine[1]
  n_buttons = button_array.size

  mia = []
  mja = []
  mar = []

  button_array.each_with_index do |button, ci|
    button.each_with_index do |value, ri|
      mia << (ri + 1)
      mja << (ci + 1)
      mar << value
    end
  end

  problem = Glpk.load_problem(
    obj_dir: :minimize,
    obj_coef: Array.new(n_buttons, 1),
    mat_ia: mia,
    mat_ja: mja,
    mat_ar: mar,
    col_kind: Array.new(n_buttons, :integer),
    col_lower: Array.new(n_buttons, 0),
    col_upper: Array.new(n_buttons, 1e5),
    row_lower: counter_target,
    row_upper: counter_target
  )

  problem.solve
end

p(sequences.sum { it[:obj_val] })
