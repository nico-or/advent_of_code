module Filesystem
  class File
    attr_reader :name, :size

    def initialize(name, size)
      @name = name
      @size = size
    end
  end
end
