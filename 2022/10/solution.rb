require_relative "lib/cpu"

cpu = CPU.from_file("input.txt")

puts cpu.signal_strength

crt = CRT.new(cpu.history)

puts crt.message
