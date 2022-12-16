describe Head do
  let(:head) { Head.new }

  describe "#position" do
    it "returns the position" do
      expect(Head.new(0, 0).position).to eq([0, 0])
      expect(Head.new(2, 5).position).to eq([2, 5])
    end
  end

  describe "#move" do
    it "moves up" do
      head.move("U 1\n")
      expect(head.position).to eq([0, 1])
      head.move("U 2\n")
      expect(head.position).to eq([0, 3])
    end

    it "moves down" do
      head.move("D 1\n")
      expect(head.position).to eq([0, -1])
      head.move("D 2\n")
      expect(head.position).to eq([0, -3])
    end

    it "moves left" do
      head.move("L 1\n")
      expect(head.position).to eq([-1, 0])
      head.move("L 2\n")
      expect(head.position).to eq([-3, 0])
    end

    it "moves right" do
      head.move("R 1\n")
      expect(head.position).to eq([1, 0])
      head.move("R 2\n")
      expect(head.position).to eq([3, 0])
    end

    it "follows the test input" do
      instructions = File.read("./spec/fixtures/input.txt")

      instructions.lines.each do |instruction|
        head.move(instruction)
      end

      expect(head.position).to eq([2, 2])
    end
  end
end
