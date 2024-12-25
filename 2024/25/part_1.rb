# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.read(FILENAME)

locks, keys = input.split("\n\n")
                   .partition { |schematic| /\#{5}/.match? schematic.lines.first.chomp }

def lock_to_array(lock)
  lock.lines(chomp: true)[1..]
      .map(&:chars)
      .each_with_object(Array.new(5) { 0 }) do |chars, acc|
    chars.each_with_index do |char, idx|
      acc[idx] += 1 if char.eql?('#')
    end
  end
end

def key_to_array(key)
  key.lines(chomp: true)[..-2]
      .map(&:chars)
      .each_with_object(Array.new(5) { 0 }) do |chars, acc|
    chars.each_with_index do |char, idx|
      acc[idx] += 1 if char.eql?('#')
    end
  end
end


count = 0

locks.each do |lock|
  keys.each do |key|
    lock_arr = lock_to_array(lock)
    key_arr = key_to_array(key)

    overlap = lock_arr.zip(key_arr).any? { |lock, key| lock + key > 5 }
    count += 1 unless overlap
  end
end

p count