describe Rucksack::Rucksack do
  let (:rucksack) { described_class.new("vJrwpWtwJgWrhcsFMMfFFhFp") }

  describe "#first" do
    it "returns the first half of the items" do
      expect(rucksack.first).to eq("vJrwpWtwJgWr")
    end
  end

  describe "#second" do
    it "returns the second half of the items" do
      expect(rucksack.second).to eq("hcsFMMfFFhFp")
    end
  end

  describe "#errors" do
    it "returns a list with all the repeated items" do
      expect(rucksack.errors).to eq(["p"])
    end
  end

  context "various" do
    it "solves the 4th rucksack correctly" do
      rucksack = described_class.new("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn")
      expect(rucksack.errors).to eq(["v"])
    end
    it "solves the 5th rucksack correctly" do
      rucksack = described_class.new("ttgJtRGJQctTZtZT")
      expect(rucksack.errors).to eq(["t"])
    end
    it "solves the 6th rucksack correctly" do
      rucksack = described_class.new("CrZsJsPPZsGzwwsLwLmpwMDw")
      expect(rucksack.errors).to eq(["s"])
    end
  end
end
