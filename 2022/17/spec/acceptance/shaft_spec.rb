describe Shaft do
  let(:shaft) { Shaft.new(7, ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>") }

  context "sample input" do
    it "has the correct appearence after adding 10 rocks" do
      output = <<~OUT
        |....#..|
        |....#..|
        |....##.|
        |##..##.|
        |######.|
        |.###...|
        |..#....|
        |.####..|
        |....##.|
        |....##.|
        |....#..|
        |..#.#..|
        |..#.#..|
        |#####..|
        |..###..|
        |...#...|
        |..####.|
        +-------+
      OUT

      10.times { shaft.new_rock! }
      puts shaft
      expect(shaft.to_s).to eq(output.chomp)
    end

    it "has a height of 3068 after adding 2022 rocks" do
      count = 2022
      count.times { shaft.new_rock! }

      expect(shaft.height).to eq(3068)
    end
  end
end
