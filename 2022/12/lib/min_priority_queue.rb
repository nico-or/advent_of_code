class MinPriorityQueue
  Entry = Struct.new(:id, :priority)

  def initialize()
    @queue = Array.new(1)
  end

  def min
    return nil if empty?

    @queue[1].id
  end

  def empty?
    @queue.all? nil
  end

  def push(id, priority)
    @queue << Entry.new(id, priority)
    move_up(@queue.length - 1)
  end

  def pop
    return nil if empty?
    out = @queue[1].id
    new_top = @queue.pop
    @queue[1] = new_top unless empty?
    move_down(1)
    out
  end

  def include?(value)
    @queue[1..].map(&:id).include? value
  end

  private

  def more(i, j)
    @queue[i].priority > @queue[j].priority
  end

  def less(i, j)
    @queue[i].priority < @queue[j].priority
  end

  def exchange(i, j)
    @queue[i], @queue[j] = @queue[j], @queue[i]
  end

  def move_up(idx)
    loop do
      parent_idx = idx / 2
      break unless idx > 1 && more(parent_idx, idx)

      exchange(parent_idx, idx)
      idx = parent_idx
    end
  end

  def move_down(idx)
    queue_size = @queue.length - 1

    loop do
      child_1_idx = idx * 2
      child_2_idx = idx * 2 + 1

      # if child_1 inbound
      break unless child_1_idx < queue_size
      # if child_2 inbound and smalles than child_1
      if child_2_idx < queue_size && more(child_1_idx, child_2_idx)
        to_idx = child_2_idx
      else
        to_idx = child_1_idx
      end
      exchange(idx, to_idx)
      idx = to_idx
    end
  end
end
