require_relative "rucksack/rucksack"
require_relative "rucksack/group"

module Rucksack
  ITEMS = ("a".."z").to_a + ("A".."Z").to_a
  VALUES = (1..52).to_a
  PRIORITIES = ITEMS.zip(VALUES).to_h

  def self.get_priority(item_char)
    PRIORITIES[item_char]
  end

  def self.load_file(filename)
    File.read(filename)
        .lines
        .map { Rucksack.new(_1.chomp) }
  end
end
