describe Forest do
  let(:forest) { Forest.from_file("./spec/fixtures/input.txt") }

  describe "#visible_trees" do
    it { expect(forest.visible_trees).to be_an(Array) }
    it do
      forest.check_visibiliy!
      expect(forest.visible_trees.count).to eq(21)
    end
  end

  describe "#left_visibility" do
    it "counts 11 trees visible from the left" do
      forest.left_visibility!
      expect(forest.visible_trees.count).to eq(11)
    end

    it "counts 11 trees visible from the right" do
      forest.right_visibility!
      p forest.trees.map(&:visible?)
      expect(forest.visible_trees.count).to eq(11)
    end

    it "counts 10 trees visible from the top" do
      forest.top_visibility!
      expect(forest.visible_trees.count).to eq(10)
    end

    it "counts 8 trees visible from the bottom" do
      forest.bottom_visibility!
      expect(forest.visible_trees.count).to eq(8)
    end
  end
end
