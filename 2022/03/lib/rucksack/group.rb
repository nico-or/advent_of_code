module Rucksack
  class Group
    def initialize(sacks)
      raise "incorrect group size" if sacks.length != 3

      @sacks = sacks
    end

    def badge
      @badge ||= @sacks[0].items
        .intersection(@sacks[1].items)
        .intersection(@sacks[2].items)
        .first
    end

    def priority
      @priority ||= PRIORITIES[badge]
    end
  end
end
