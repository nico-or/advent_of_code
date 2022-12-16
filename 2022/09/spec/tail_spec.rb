describe Tail do
  let(:head) { Head.new }
  let(:tail) { head.tail }

  describe "#initialize" do
    it "starts in the same position that head" do
      expect(tail.position).to eq(head.position)
      expect(tail.position).to eq([0, 0])
    end
  end

  describe "#touching?" do
    it "true when both are in the same position" do
      expect(tail.touching?).to eq(true)
    end
    it "true when head is 1 step away" do
      head.position.x = 1
      expect(tail.touching?).to eq(true)
    end
    it "true when head is in a diagonal" do
      head.position.x = 1
      head.position.y = 1
      expect(tail.touching?).to eq(true)
    end
    it "false when head is 2 or more steps away" do
      head.position.x = 2
      expect(tail.touching?).to eq(false)
    end
    it "false when head is in a big diagonal" do
      head.position.x = 1
      head.position.y = 2
      expect(tail.touching?).to eq(false)
    end
    it "false when head is in a big diagonal" do
      head.position.x = -2
      head.position.y = -1
      expect(tail.touching?).to eq(false)
    end
  end

  describe "#update!"
  it "[R 1, U 2] diagonal" do
    head.position.x = 1
    head.position.y = 2

    tail.update!

    expect(tail.position).to eq([1, 1])
  end
  it "[L 2, D 1] diagonal" do
    head.position.x = -2
    head.position.y = -1

    tail.update!

    expect(tail.position).to eq([-1, -1])
  end
end
