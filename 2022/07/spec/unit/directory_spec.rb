describe Filesystem::Directory do
  let(:directory) { Filesystem::Directory.new("foo") }

  context "new empty directory" do
    describe "#name" do
      it { expect(directory.name).to eq("foo") }
    end

    describe "#size" do
      it { expect(directory.size).to eq(0) }
    end
  end

  context "directory with files" do
    before do
      directory << Filesystem::File.new("foo.bar", 13)
      directory << Filesystem::File.new("bar.baz", 7)
    end
    it { expect(directory.size).to eq(20) }
    it { expect(directory.childs.count).to eq(2) }
  end

  context "directory with files and directories" do
    before do
      directory << Filesystem::File.new("foo.bar", 13)
      directory << Filesystem::File.new("bar.baz", 7)
      directory << Filesystem::Directory.new("tmp")
    end
    it { expect(directory.size).to eq(20) }
    it { expect(directory.childs.count).to eq(3) }
  end

  describe "#parent" do
    it do
      child = Filesystem::Directory.new("test", directory)
      directory << child

      expect(directory.childs.count).to eq(1)
      expect(directory.childs).to include(child)
      expect(child.parent).to eq(directory)
    end
  end
end
