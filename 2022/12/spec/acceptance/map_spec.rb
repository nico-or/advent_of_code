describe Map do
  let(:map) { Map.from_file("./spec/fixtures/input.txt") }

  describe "#path" do
    it "returns the shortest path" do
      pending
      path = map.path
      expect(path.length).to eq(31)
    end
  end
end
