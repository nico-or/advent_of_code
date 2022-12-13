describe Rucksack do
  describe "#get_priority" do
    it { expect(Rucksack.get_priority("a")).to eq(1) }
    it { expect(Rucksack.get_priority("z")).to eq(26) }
    it { expect(Rucksack.get_priority("A")).to eq(27) }
    it { expect(Rucksack.get_priority("Z")).to eq(52) }
  end
end
