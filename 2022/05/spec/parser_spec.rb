describe Parser do
  let(:parser) { Parser.new }

  describe "#stack_count" do
    it { expect(parser.stack_count).to eq(3) }
  end

  describe "#crate_items" do
    it do
      output = [" ", "D", " ", "N", "C", " ", "Z", "M", "P"]
      expect(parser.crate_items).to eq(output)
    end
  end

  describe "#output" do
    it "returns the correct crates" do
      output = [
        %W[Z N],
        %W[M C D],
        %w[P],
      ]
      expect(parser.output).to eq(output)
    end
  end

  describe "#instructions" do
    it do
      sample = [
        "move 1 from 2 to 1",
        "move 3 from 1 to 3",
        "move 2 from 2 to 1",
        "move 1 from 1 to 2",
      ]

      expect(parser.instructions).to eq(sample)
    end
  end
end
