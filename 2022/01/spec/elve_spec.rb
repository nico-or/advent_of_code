describe Elve do
  let (:subject) { Elve.new([1000, 2000, 3000]) }
  describe "#total_calories" do
    it "returns the total amount of calories" do
      expect(subject.total_calories).to eq(6000)
    end
  end
end
