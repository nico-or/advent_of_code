describe CalorieCounter do
  let(:calorie_counter) { described_class.new(test_input) }

  describe "#max_calories" do
    it "returns the highest amount of calories carried by 1 elve" do
      expect(calorie_counter.max_calories).to eq(24_000)
    end
    it "returns the highest amount of calories carried by 3 elves" do
      expect(calorie_counter.max_calories(3)).to eq(45_000)
    end
  end
end
