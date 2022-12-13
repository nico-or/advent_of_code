describe Assigment do
  describe "#include?" do
    let(:assigment) { described_class.new("2-4") }
    it "returns false for a number outside the range" do
      expect(assigment.include?(1)).to eq(false)
    end
    it "returns true for a number inside the range" do
      expect(assigment.include?(2)).to eq(true)
    end
  end

  describe "#fully_contains?" do
    context "first fully contains second" do
      let(:first_assigment) { described_class.new("2-8") }
      let(:second_assigment) { described_class.new("3-7") }

      it "returns true for an assigment fully contained" do
        expect(first_assigment.fully_contain?(second_assigment)).to eq(true)
      end
      it "returns false for an assigment not fully container" do
        expect(second_assigment.fully_contain?(first_assigment)).to eq(false)
      end
    end

    context "second fully contains first" do
      let(:first_assigment) { described_class.new("3-7") }
      let(:second_assigment) { described_class.new("2-8") }

      it "returns true for an assigment fully contained" do
        expect(second_assigment.fully_contain?(first_assigment)).to eq(true)
      end
      it "returns false for an assigment not fully container" do
        expect(first_assigment.fully_contain?(second_assigment)).to eq(false)
      end
    end

    context "single section assigment" do
      let(:first_assigment) { described_class.new("3-7") }
      let(:second_assigment) { described_class.new("5-5") }

      it "returns true for an assigment fully contained" do
        expect(first_assigment.fully_contain?(second_assigment)).to eq(true)
      end
      it "returns false for an assigment not fully container" do
        expect(second_assigment.fully_contain?(first_assigment)).to eq(false)
      end
    end
  end

  describe "#overlap?" do
    context "partially contained assigments" do
      let(:first) { described_class.new ("2-8") }
      let(:second) { described_class.new ("6-10") }

      it { expect(first.overlap?(second)).to be(true) }
      it { expect(second.overlap?(first)).to be(true) }
    end

    context "fully contained assigments" do
      let(:first) { described_class.new ("2-8") }
      let(:second) { described_class.new ("4-4") }

      it { expect(first.overlap?(second)).to be(true) }
      it { expect(second.overlap?(first)).to be(true) }
    end

    context "non overlaping assigments" do
      let(:first) { described_class.new ("2-5") }
      let(:second) { described_class.new ("6-7") }

      it { expect(first.overlap?(second)).to be(false) }
      it { expect(second.overlap?(first)).to be(false) }
    end
  end
end
