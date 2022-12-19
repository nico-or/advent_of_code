describe "ordered?" do
  context "when both Integers" do
    it "true when left < right" do
      expect(ordered?(0, 1)).to eq(true)
    end
    it "false when left > right" do
      expect(ordered?(1, 0)).to eq(false)
    end
    it "nil when left == right" do
      expect(ordered?(0, 0)).to eq(nil)
    end
  end

  context "when both Arrays" do
    it "true for [0], [1]" do
      expect(ordered?([0], [1])).to eq(true)
    end
    it "false for [1], [0]" do
      expect(ordered?([1], [0])).to eq(false)
    end
    it "true for [], [1]" do
      expect(ordered?([], [1])).to eq(true)
    end
    it "false for [1], []" do
      expect(ordered?([1], [])).to eq(false)
    end
    it "true for [1], [1,1]" do
      expect(ordered?([1], [1, 1])).to eq(true)
    end
    it "false for [1,1], [1]" do
      expect(ordered?([1, 1], [1])).to eq(false)
    end
  end

  context "when one Integer and one Array" do
    it "true for [0], 1" do
      expect(ordered?([0], 1)).to eq(true)
    end
    it "false for [1], 0" do
      expect(ordered?([1], 0)).to eq(false)
    end
  end
end
