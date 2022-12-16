describe "Acceptance" do
  context "first part" do
    it do
      head = Head.new

      instructions = File.read("./spec/fixtures/input.txt")
      instructions.lines.each do |instruction|
        head.move(instruction)
      end

      visited_points = head.tail.memory

      expect(visited_points.uniq(&:to_s).count).to eq(13)
    end
  end

  context "second part" do
    it "small input" do
      head = Head.new(0, 0, 9)

      instructions = File.read("./spec/fixtures/input.txt")

      instructions.lines.each do |instruction|
        head.move(instruction)
      end

      visited_points = head.knots.last.memory

      expect(visited_points.uniq(&:to_s).count).to eq(1)
    end

    it "large input" do
      head = Head.new(0, 0, 9)

      instructions = File.read("./spec/fixtures/multiple.txt")

      instructions.lines.each do |instruction|
        head.move(instruction)
      end

      visited_points = head.knots.last.memory

      expect(visited_points.uniq(&:to_s).count).to eq(36)
    end
  end
end
