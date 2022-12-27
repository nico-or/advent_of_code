describe Shaft do
  let(:shaft) { Shaft.new }

  describe "#to_s" do
    it "prints an empty shaft" do
      representation = <<~TOS
        +-------+
      TOS

      expect(shaft.to_s).to eq(representation.chomp)
    end
  end

  describe "#new_rock!" do
    it "shows the correct shaft after the first rock" do
      representation = <<~TOS
        |..####.|
        +-------+
      TOS
      shaft.new_rock!(0)
      expect(shaft.to_s).to eq(representation.chomp)
    end

    it "updates the height after adding a rock" do
      expect(shaft.height).to eq(0)
      shaft.new_rock!(0)
      expect(shaft.height).to eq(1)
    end

    it "show the correct shaft after the first 2 rocks" do
      representation = <<~TOS
        |...#...|
        |..###..|
        |...#...|
        |..####.|
        +-------+
      TOS
      shaft.new_rock!(0)
      shaft.new_rock!(1)
      expect(shaft.to_s).to eq(representation.chomp)
    end
  end
end
