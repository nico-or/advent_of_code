describe Filesystem::File do
  let(:file) { Filesystem::File.new("test.txt", 124) }
  describe "#name" do
    it { expect(file.name).to eq("test.txt") }
  end
  describe "#size" do
    it { expect(file.size).to eq(124) }
  end
end
