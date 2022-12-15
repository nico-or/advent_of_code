require_relative "lib/filesystem"

filesystem = Filesystem::Filesystem.new

File.read("input.txt").lines.each do |instruction|
  Filesystem.instruction(instruction, filesystem)
end

directories = filesystem.find_recursive do |child|
  child.instance_of?(Filesystem::Directory) && child.size < 100_000
end

puts "Total size of directories with size of at most 100_000: #{directories.sum(&:size)}"

available_space = Filesystem::DISK_SIZE - filesystem.size
min_to_delete = Filesystem::UPDATE_SIZE - available_space

output = filesystem.directories.select do |dir|
  dir.size >= min_to_delete
end.min

puts "Delete directory: #{output.name}"
puts "Space to free: #{output.size}"
