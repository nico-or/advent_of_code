module Filesystem
  class Node
    include Comparable

    def <=>(other)
      size <=> other.size
    end
  end
end
