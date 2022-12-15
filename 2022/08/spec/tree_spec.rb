describe Tree do
  describe "#visible?" do
    let(:visible) { described_class.new(0).tap { _1.visible! } }
    let(:invisible) { described_class.new(0) }

    it { expect(visible.visible?).to eq(true) }
    it { expect(invisible.visible?).to eq(false) }
  end

  describe "#visible!" do
    let(:invisible) { described_class.new(0) }

    it { expect(invisible.visible!.visible?).to eq(true) }
  end
end
