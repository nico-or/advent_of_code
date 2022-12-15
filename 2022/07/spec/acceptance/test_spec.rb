describe "sample input" do
  let(:filesystem) do
    filesystem = Filesystem::Filesystem.new

    input = File.read("./spec/fixtures/input.txt")
    input.lines.each do |instruction|
      Filesystem.instruction(instruction, filesystem)
    end
    return filesystem
  end

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
end
