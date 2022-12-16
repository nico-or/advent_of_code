describe "Integration" do
  let(:head) { Head.new }
  let(:tail) { head.tail }

  describe "Tail follows head" do
    it "starts in the same position" do
      expect(head.position).to eq(tail.position)
    end

    it "doesnt moves when head moves 1 step" do
      tail_initial_position = tail.position.dup
      head.move("R 1")
      tail_ending_position = tail.position.dup
      expect(tail_initial_position).to eq(tail_ending_position)
    end

    it "moves towards the head when head moves 2 steps away" do
      tail_initial_position = tail.position.dup
      head.move("R 2")
      tail_ending_position = tail.position.dup
      expect(tail_initial_position).to_not eq(tail_ending_position)
      expect(tail_ending_position).to eq([1, 0])
    end
  end

  describe "diagonal movement" do
    it "tail moves [R 1, U 2] correctly" do
      head.move("R 1")
      head.move("U 2")

      expect(tail.position).to eq([1, 1])
    end
  end

  describe "sample input" do
    it do
      [
        ["R 4", [
          [0, 0], [1, 0], [2, 0], [3, 0],
        ]],
        ["U 4", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
        ]],
        ["L 3", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
          [3, 4], [2, 4],
        ]],
        ["D 1", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
          [3, 4], [2, 4],
        ]],
        ["R 4", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
          [3, 4], [2, 4],
          [3, 3], [4, 3],
        ]],
        ["D 1", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
          [3, 4], [2, 4],
          [3, 3], [4, 3],
        ]],
        ["L 5", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
          [3, 4], [2, 4],
          [3, 3], [4, 3],
          [3, 2], [2, 2], [1, 2],
        ]],
        ["R 2", [
          [0, 0], [1, 0], [2, 0], [3, 0],
          [4, 1], [4, 2], [4, 3],
          [3, 4], [2, 4],
          [3, 3], [4, 3],
          [3, 2], [2, 2], [1, 2],
        ]],
      ].each do |instruction, memo|
        head.move(instruction)
        expect(tail.memory).to eq(memo)
      end
    end
  end
end
