describe Rucksack::Group do
  let(:group) do
    input = <<~INPUT
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
    INPUT

    described_class.new(
      input.lines
           .map { Rucksack::Rucksack.new(_1.chomp) }
    )
  end

  describe "#badge" do
    it "returns 'r' as the group badge" do
      expect(group.badge).to eq("r")
    end
  end
  describe "#priority" do
    it "returns 18 as the group priority" do
      expect(group.priority).to eq(18)
    end
  end
end
