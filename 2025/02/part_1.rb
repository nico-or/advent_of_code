filename = ARGV[0]

input = File.read(filename, chomp: true)

ranges = input.scan(/\d+/).map(&:to_i).each_slice(2)

# matches values like: 11, 1212, 123123, abab, but not: 1122, aabb
regex = /^(\d+)\1$/
sum = 0

# slow, takes almost 1 second
ranges.each do |(first, last)|
  values = first.upto(last)
  sum += values.select { regex.match? it.to_s }.sum
end

puts sum