module Filesystem
  class Directory
    attr_reader :name, :childs, :parent

    def initialize(name, parent = nil)
      @name = name
      @childs = []
      @parent = parent
    end

    def <<(other)
      @childs << other
    end

    def size
      @childs.map(&:size).sum
    end
  end
end
