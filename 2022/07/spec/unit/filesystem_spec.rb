describe Filesystem::Filesystem do
  let(:filesystem) do
    fs = Filesystem::Filesystem.new
    fs.mkdir("/")
    return fs
  end

  describe "#initialize" do
    it { expect(filesystem.name).to eq("/") }
    it { expect(filesystem.size).to eq(0) }
    it { expect(filesystem.childs.count).to eq(0) }
  end

  describe "#mkdir" do
    before do
      filesystem.mkdir("foo")
    end

    it { expect(filesystem.size).to eq(0) }
    it { expect(filesystem.childs.count).to eq(1) }
  end

  describe "#cd" do
    before do
      filesystem.mkdir("foo")
    end

    it "goes down the filesystem" do
      filesystem.cd("foo")
      expect(filesystem.name).to eq("foo")
    end

    it "goes up the filesystem" do
      filesystem.cd("foo")
      filesystem.cd("..")
      expect(filesystem.name).to eq("/")
    end
  end
end
