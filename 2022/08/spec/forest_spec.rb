describe Forest do
  let(:forest) { Forest.from_file("./spec/fixtures/input.txt") }

  describe "#visible_trees" do
    it { expect(forest.visible_trees).to be_an(Array) }
    it do
      expect(forest.visible_trees.count).to eq(21)
    end
  end

  describe "#surrounding_trees" do
    it "works on a corner tree" do
      foo = forest.surrounding_trees(0, 0)

      expect(foo[:left].map(&:height)).to eq([])
      expect(foo[:right].map(&:height)).to eq([0, 3, 7, 3])
      expect(foo[:top].map(&:height)).to eq([])
      expect(foo[:bottom].map(&:height)).to eq([2, 6, 3, 3])
    end

    it "works on a wall tree" do
      foo = forest.surrounding_trees(4, 2)

      expect(foo[:left].map(&:height)).to eq([3, 5])
      expect(foo[:right].map(&:height)).to eq([9, 0])
      expect(foo[:top].map(&:height)).to eq([3, 5, 3, 5])
      expect(foo[:bottom].map(&:height)).to eq([])
    end

    it "works on a middle tree" do
      foo = forest.surrounding_trees(3, 1)

      expect(foo[:left].map(&:height)).to eq([3])
      expect(foo[:right].map(&:height)).to eq([5, 4, 9])
      expect(foo[:top].map(&:height)).to eq([0, 5, 5])
      expect(foo[:bottom].map(&:height)).to eq([5])
    end
  end
end
