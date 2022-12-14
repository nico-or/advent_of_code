require_relative "lib/device"

device = Device.new(File.read "input.txt")
puts "Message marker count: #{device.packet_marker}"
puts "Message marker count: #{device.message_marker}"
