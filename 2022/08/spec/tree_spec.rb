describe Tree do
  describe "#visible?" do
    let(:visible) { described_class.new(0).tap { _1.visible! } }
    let(:invisible) { described_class.new(0) }

    it { expect(visible.visible?).to eq(true) }
    it { expect(invisible.visible?).to eq(false) }
  end

  describe "#visible!" do
    let(:invisible) { described_class.new(0) }

    it { expect(invisible.visible!.visible?).to eq(true) }
  end

  describe "#view_distance" do
    it "calculates score for a tree row" do
      tree = Tree.new(5)
      row = [3, 5, 3].map { Tree.new(_1) }
      dist = tree.view_distance(row)
      expect(dist).to eq(2)
    end

    it "returns 0 for an empty row of trees" do
      tree = Tree.new(5)
      row = [].map { Tree.new(_1) }
      dist = tree.view_distance(row)
      expect(dist).to eq(0)
    end

    it "returns row lenght for an fully seen row of trees" do
      tree = Tree.new(5)
      row = [1, 1, 1, 1].map { Tree.new(_1) }
      dist = tree.view_distance(row)
      expect(dist).to eq(4)
    end
  end
end
