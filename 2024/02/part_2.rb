# frozen_string_literal: true

filename = ARGV[0]
input = File.read(filename)

sequences = input
            .split("\n")
            .map { |row| row.scan(/\d+/).map(&:to_i) }

def decreasing?(sequence)
  sequence.each_cons(2).all? { |a, b| a > b }
end

def increasing?(sequence)
  sequence.each_cons(2).all? { |a, b| b > a }
end

def monotonic?(sequence)
  decreasing?(sequence) || increasing?(sequence)
end

def stable?(sequence, min_diff, max_diff)
  sequence.each_cons(2).all? { |a, b| (a - b).abs.between?(min_diff, max_diff) }
end

def dampen_sequence(sequence)
  sequence.combination(sequence.length - 1)
end

MIN_DIFF = 1
MAX_DIFF = 3

def safe?(sequence)
  return true if monotonic?(sequence) && stable?(sequence, MIN_DIFF, MAX_DIFF)
  
  dampen_sequence(sequence).any? { |seq| monotonic?(seq) && stable?(seq, MIN_DIFF, MAX_DIFF) }
end

safe_report_count = sequences.count { |seq| safe?(seq) }

puts "Number of safe reports: #{safe_report_count}"
