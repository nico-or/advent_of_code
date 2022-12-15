describe Filesystem::File do
  let(:file) { Filesystem::File.new("test.txt", 124) }
  describe "#name" do
    it { expect(file.name).to eq("test.txt") }
  end
  describe "#size" do
    it { expect(file.size).to eq(124) }
  end

  describe "#<=>" do
    let(:big) { Filesystem::File.new("big", 10) }
    let(:small) { Filesystem::File.new("small", 1) }

    it do
      expect(big > small).to eq(true)
      expect(big == big).to eq(true)
      expect(big < small).to eq(false)
    end
  end
end
