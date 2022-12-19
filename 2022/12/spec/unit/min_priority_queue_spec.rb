describe MinPriorityQueue do
  let(:queue) { MinPriorityQueue.new }

  describe "#min" do
    it "returns nil when queue is empty" do
      expect(queue.min).to eq(nil)
    end
    it "returns the item with less priority" do
      queue.push("high", 1)
      queue.push("low", 0)
      expect(queue.min).to eq("low")
    end
    it "returns the item with less priority" do
      queue.push(:item, 0)
      queue.push("high", 1)
      expect(queue.min).to eq(:item)
    end
    it "doesn't remove the item from the top" do
      queue.push("low", 0)
      2.times { expect(queue.min).to eq("low") }
      expect(queue.empty?).to eq(false)
    end
  end

  describe "#empty?" do
    it "returns true for a new queue" do
      expect(queue.empty?).to eq(true)
    end
    it "returns false for a queue with items" do
      queue.push("low", 0)
      expect(queue.empty?).to eq(false)
    end
  end

  describe "#pop" do
    before do
      queue.push("low", 0)
      queue.push("high", 1)
    end
    it "returns the item with lowest priority" do
      min = queue.min
      expect(queue.pop).to eq(min)
    end
    it "removes the item from the top" do
      expect(queue.pop).to eq("low")
      expect(queue.min).to eq("high")
    end
    it "empties the queue" do
      expect(queue.pop).to eq("low")
      expect(queue.pop).to eq("high")
      expect(queue.pop).to eq(nil)
    end
  end

  context "inserting shuffled integers" do
    before do
      items = (0...6).to_a.shuffle
      items.each { |item| queue.push(item, item) }
      #p queue.instance_variable_get(:@queue)[1..].map(&:priority)
    end

    it "sorts correctly" do
      expect(queue.min).to eq(0)
    end

    it "returns all item in correct order" do
      5.times { queue.pop }
      p queue.instance_variable_get(:@queue)[1..].map(&:priority)
    end
  end
end
