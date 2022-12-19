describe Graph do
  let(:graph) do
    Graph.new(3)
  end

  before do
    graph.add_edge(0, 1)
  end

  describe "#adj" do
    it do
      expect(graph.adj(0)).to eq([1])
      expect(graph.adj(1)).to eq([])
    end
  end

  describe "#adj?" do
    it "returns true for connected edges" do
      expect(graph.adj?(0, 1)).to eq(true)
    end

    it "returns false for non-connected edges" do
      expect(graph.adj?(1, 0)).to eq(false)
    end
  end

  describe "#to_s" do
    it do
      graph.add_edge(0, 0)
      graph.add_edge(2, 1)

      output = <<~TXT
        [0] → [1, 0]
        [1] → []
        [2] → [1]
      TXT

      expect(graph.to_s).to eq(output)
    end
  end
end
