# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.read(FILENAME)

values = input.split("\n\n")
              .map { _1.scan(/\d+/).map(&:to_i) }

PRESS_LIMIT = 100
values.reduce(0) do |acc, arr|
  button_a = Complex(arr[0], arr[1])
  button_b = Complex(arr[2], arr[3])
  target = Complex(arr[4], arr[5])
  out = 0
  (0..PRESS_LIMIT).each do |na|
    (0..PRESS_LIMIT).each do |nb|
      out = 3 * na + nb if target.eql?(button_a * na + button_b * nb)
    end
  end
  acc + out
end.then { p _1 }
