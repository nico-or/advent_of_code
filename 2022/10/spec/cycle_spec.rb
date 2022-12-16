describe Cycle do
  let(:cycle) { Cycle.new(0, 1) }

  describe "#next" do
    it "works with no argument" do
      next_cycle = cycle.next

      expect(next_cycle.number).to eq(1)
      expect(next_cycle.value).to eq(1)
    end

    it "works with argument" do
      next_cycle = cycle.next(5)

      expect(next_cycle.number).to eq(1)
      expect(next_cycle.value).to eq(6)
    end
  end

  describe "#signal_strength" do
    it do
      cycle = Cycle.new(20, 21)
      expect(cycle.signal_strength).to eq(420)
    end
  end
end
