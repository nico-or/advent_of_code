describe Filesystem do
  describe "::instruction" do
    let(:filesystem) { instance_double(Filesystem::Filesystem) }

    it "creates a root directory" do
      input = "$ cd /\n"

      expect(filesystem).to receive(:mkdir).with("/")

      Filesystem.instruction(input, filesystem)
    end

    it "creates files and subdrectories" do
      input = <<~INPUT
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
      INPUT

      expect(filesystem).to receive(:mkdir).with("/")
      expect(filesystem).to receive(:mkdir).with("a")
      expect(filesystem).to receive(:touch).with("b.txt", 14848514)
      expect(filesystem).to receive(:touch).with("c.dat", 8504156)

      input.lines.each do |instruction|
        Filesystem.instruction(instruction, filesystem)
      end
    end

    it "creates navigates the filesystem" do
      input = <<~INPUT
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ cd ..
      INPUT

      expect(filesystem).to receive(:mkdir).with("/")
      expect(filesystem).to receive(:mkdir).with("a")
      expect(filesystem).to receive(:touch).with("b.txt", 14848514)
      expect(filesystem).to receive(:touch).with("c.dat", 8504156)
      expect(filesystem).to receive(:mkdir).with("d")
      expect(filesystem).to receive(:cd).with("a")
      expect(filesystem).to receive(:cd).with("..")

      input.lines.each do |instruction|
        Filesystem.instruction(instruction, filesystem)
      end
    end
  end
end
