describe Map do
  let(:map) { Map.from_file("./spec/fixtures/input.txt") }

  describe "::from_file" do
    it "creates a map object" do
      expect(map).to be_a(Map)
    end
  end

  describe "#to_s" do
    it "returns an squared representation of the map" do
      output = "Sabqponm\nabcryxxl\naccszExk\nacctuvwj\nabdefghi"
      expect(map.to_s).to eq(output)
    end
  end

  describe "#start_index" do
    it "returns the index of the start position " do
      expect(map.start_index).to eq(0)
    end
  end

  describe "#end_index" do
    it "returns the index of the end position " do
      expect(map.end_index).to eq(21)
    end
  end

  describe "#adj" do
    it "returns the adjacent indexes of the start position" do
      adj = map.adj(map.start_index)
      expect(adj).to contain_exactly(1, 8)
    end
    it "returns the adjacent indexes of the index #2" do
      adj = map.adj(2)
      expect(adj).to contain_exactly(1, 10)
    end
    it "returns the adjacent indexes of the (right of END) position" do
      idx = map.end_index + 1
      adj = map.adj(idx)
      expect(adj).to contain_exactly(idx - 8, idx + 8, idx + 1)
    end
  end
end
