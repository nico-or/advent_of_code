describe Filesystem do
  let(:filesystem) { Filesystem.from_file("./spec/fixtures/input.txt") }

  it "has correct size" do
    expect(filesystem.root.size).to eq(
      14_848_514 + 8_504_156 + 29_116 + 2_557 + 62_596 +
      584 + 4_060_174 + 8_033_020 + 5_626_152 + 7_214_296
    )
  end

  it "heads ends in d directory" do
    expect(filesystem.head.name).to eq("d")
  end

  it "returns directories with size less than 100_000" do
    threshold = 100_000

    directories = filesystem.find_recursive do |child|
      child.instance_of?(Filesystem::Directory) && child.size < threshold
    end

    expect(directories.sum(&:size)).to eq(95_437)
  end

  it "selects directory 'd' as the one to delete" do
    available_space = Filesystem::DISK_SIZE - filesystem.size
    min_to_delete = Filesystem::UPDATE_SIZE - available_space

    output = filesystem.directories.select do |dir|
      dir.size >= min_to_delete
    end.min

    expect(output.name).to eq("d")
  end
end
