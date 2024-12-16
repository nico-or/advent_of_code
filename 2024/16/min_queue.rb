# frozen_string_literal: true

class MinQueue
  Node = Struct.new(:element, :priority) do
    def to_s
      "(#{element}, #{priority})"
    end
  end

  def initialize
    @array = []
  end

  def push(element, priority)
    @array << Node.new(element, priority)
    bubble_up
  end

  def pop
    @array[0], @array[-1] = @array[-1], @array[0]
    out = @array.pop
    bubble_down
    out.element
  end

  def empty?
    @array.empty?
  end

  def to_s
    @array.map(&:to_s).inspect
  end

  private

  def bubble_up
    len = @array.length
    index = len - 1
    node = @array[index]
    parent = @array[(index - 1) / 2]

    until index.zero? || parent.priority < node.priority
      @array[index], @array[(index - 1) / 2] = @array[(index - 1) / 2], @array[index]
      index = (index - 1) / 2
      parent = @array[(index - 1) / 2]
    end
  end

  def bubble_down
    index = 0
    loop do
      node = @array[index]
      l_child = @array[2 * index + 1]
      r_child = @array[2 * index + 2]

      break if [l_child, r_child].compact.all? { _1 && _1.priority >= node.priority }

      case (l_child&.priority || Float::INFINITY) <=> (r_child&.priority || Float::INFINITY)
      when 1
        if r_child && r_child.priority < node.priority
          @array[index], @array[2 * index + 2] = @array[2 * index + 2], @array[index]
          index = 2 * index + 2
        end
      else
        if l_child && l_child.priority < node.priority
          @array[index], @array[2 * index + 1] = @array[2 * index + 1], @array[index]
          index = 2 * index + 1
        end
      end
    end
  end
end
