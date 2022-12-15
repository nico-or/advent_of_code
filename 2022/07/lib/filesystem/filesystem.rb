module Filesystem
  class Filesystem
    attr_reader :root, :head

    def size
      root.size
    end

    def mkdir(name)
      if root.nil?
        @root = Directory.new(name)
        @head = root
      else
        head << Directory.new(name, head)
      end
    end

    def touch(name, size)
      head << File.new(name, size)
    end

    def cd(name)
      if name.eql?("..")
        @head = head.parent
        return
      end

      return nil unless childs.any? do |child|
        child.name.eql?(name) &&
        child.instance_of?(Directory)
      end

      @head = childs.select do |child|
        child.name.eql?(name) &&
        child.instance_of?(Directory)
      end.first
    end

    def method_missing(method_name, *args)
      head.send(method_name)
    end

    def find_recursive(&block)
      output = []
      queue = [root]
      until queue.empty?
        current = queue.shift
        queue += current.childs if current.instance_of? Directory
        output << current if yield(current)
      end
      output
    end
  end
end
