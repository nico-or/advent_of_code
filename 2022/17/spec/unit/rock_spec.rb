describe Rock do
  describe "::next" do
    xit "creates rocks in the correct order" do
      13.times do
        rock = Rock.next
        pos = Rock::ROCKS[_1 % Rock::ROCKS.length]
        expect(rock.positions).to eq(pos)
      end
    end
  end

  describe "#initialize" do
    it "defaults to a height = 0 rock" do
      rock = Rock.new
      pos = [[0, 0], [0, 1], [0, 2], [0, 3]]
      expect(rock.positions).to eq(pos)
    end
    it "creates rocks in specific heights" do
      rock = Rock.new([4, 0])
      pos = [[4, 0], [4, 1], [4, 2], [4, 3]]
      expect(rock.positions).to eq(pos)
    end
  end

  let(:rock) { Rock.new([2, 2], 0) }

  describe "#fall!" do
    it "shifts all positions 1 row down" do
      expected_positions = [[1, 2], [1, 3], [1, 4], [1, 5]]
      occupied_positions = []
      rock.fall!(occupied_positions)
      expect(rock.positions).to eq(expected_positions)
    end

    context "falling into the floor" do
      let(:rock) { Rock.new([0, 0], 0) }

      it "won't move further after hitting the floor" do
        occupied_positions = []
        rock.fall!(occupied_positions)
        original_positions = [[0, 0], [0, 1], [0, 2], [0, 3]]
        expect(rock.positions).to eq(original_positions)
      end
      it "will change the @falling flag to false" do
        expect(rock.falling?).to eq(true)
        occupied_positions = []
        rock.fall!(occupied_positions)
        expect(rock.falling?).to eq(false)
      end
    end

    context "falling into another rock" do
      let(:rock) { Rock.new([1, 0], 0) }

      it "stops when fallin over occupied positions" do
        occupied_positions = [[0, 0]]
        rock.fall!(occupied_positions)
        original_positions = [[1, 0], [1, 1], [1, 2], [1, 3]]
        expect(rock.positions).to eq(original_positions)
      end
    end
  end

  describe "#move_left!" do
    it "shifts all positions 1 col left" do
      expected_positions = [[2, 1], [2, 2], [2, 3], [2, 4]]
      rock.move_left!([], 0, 7)
      expect(rock.positions).to eq(expected_positions)
    end

    context "trying to move past a side wall" do
      let(:rock) { Rock.new([0, 0], 0) }

      it "won't move further after hitting a wall" do
        rock.move_left!([[]], 0, 7)
        original_positions = [[0, 0], [0, 1], [0, 2], [0, 3]]
        expect(rock.positions).to eq(original_positions)
      end
    end

    context "clasing with another rock" do
      it "doesn't move if a rock is in the way" do
        rock = Rock.new([0, 1], 0)
        occupied_positions = [[0, 0]]
        expected_positions = [[0, 1], [0, 2], [0, 3], [0, 4]]

        rock.move_left!(occupied_positions, 0, 7)

        expect(rock.positions).to eq(expected_positions)
        expect(rock.falling?).to eq(true)
      end
    end
  end

  describe "#move_right!" do
    it "shifts all positions 1 col right" do
      expected_positions = [[2, 3], [2, 4], [2, 5], [2, 6]]
      rock.move_right!([], 0, 7)
      expect(rock.positions).to eq(expected_positions)
    end

    context "trying to move past a side wall" do
      let(:width) { 4 }
      let(:rock) { Rock.new([0, 0], 0) }

      it "won't move further after hitting a wall" do
        rock.move_right!([], 0, 3)
        original_positions = [[0, 0], [0, 1], [0, 2], [0, 3]]
        expect(rock.positions).to eq(original_positions)
      end
    end

    context "clasing with another rock" do
      it "doesn't move if a rock is in the way" do
        rock = Rock.new([0, 1], 0)
        occupied_positions = [[0, 5]]
        expected_positions = [[0, 1], [0, 2], [0, 3], [0, 4]]

        rock.move_right!(occupied_positions, 0, 7)

        expect(rock.positions).to eq(expected_positions)
        expect(rock.falling?).to eq(true)
      end
    end
  end

  describe "#max_height" do
    it "returns 0 for an unshifted flat rock" do
      rock = Rock.new([0, 0], 0)
      expect(rock.max_height).to eq(0)
    end
    it "returns 2 for an unshifted cross rock" do
      rock = Rock.new([0, 0], 1)
      expect(rock.max_height).to eq(2)
    end
    it "returns 4 for an shifted L rock" do
      rock = Rock.new([2, 0], 2)
      expect(rock.max_height).to eq(4)
    end
  end

  describe "#move!" do
    let(:shaft) do
      instance_double("Shaft", width: 7, occupied_positions: [])
    end

    context "freefall" do
      it "moves the rock to the left then down" do
        rock = Rock.new([1, 1], 0)
        new_positions = [[0, 0], [0, 1], [0, 2], [0, 3]]
        rock.move!(:<, shaft)
        expect(rock.positions).to eq(new_positions)
        expect(rock.falling?).to eq(true)
      end
      it "moves the rock to the right then down" do
        rock = Rock.new([1, 1], 0)
        new_positions = [[0, 2], [0, 3], [0, 4], [0, 5]]
        rock.move!(:>, shaft)
        expect(rock.positions).to eq(new_positions)
        expect(rock.falling?).to eq(true)
      end
    end

    context "next to the floor" do
      let(:rock) { Rock.new([0, 1], 0) }
      it "moves the rock to the left then hits the ground" do
        new_positions = [[0, 0], [0, 1], [0, 2], [0, 3]]
        rock.move!(:<, shaft)
        expect(rock.positions).to eq(new_positions)
        expect(rock.falling?).to eq(false)
      end
      it "moves the rock to the right then hits the ground" do
        new_positions = [[0, 2], [0, 3], [0, 4], [0, 5]]
        rock.move!(:>, shaft)
        expect(rock.positions).to eq(new_positions)
        expect(rock.falling?).to eq(false)
      end
    end

    context "next to a wall" do
      let(:rock) { Rock.new([2, 0], 0) }
      let(:shaft) do
        instance_double("Shaft", width: 4, occupied_positions: [])
      end
      let(:final_positions) { [[1, 0], [1, 1], [1, 2], [1, 3]] }
      it "doesn't move to the left" do
        rock.move!(:<, shaft)
        expect(rock.positions).to eq(final_positions)
      end
      it "doesn't move to the right" do
        rock.move!(:>, shaft)
        expect(rock.positions).to eq(final_positions)
      end
    end

    context "clash with rock, then falls" do
      let(:rock) { Rock.new([2, 1], 0) }
      let(:shaft) do
        instance_double("Shaft", width: 6, occupied_positions: [[2, 0], [2, 5]])
      end
      let(:final_positions) { [[1, 1], [1, 2], [1, 3], [1, 4]] }

      it "doesn't move to the left" do
        rock.move!(:<, shaft)
        expect(rock.positions).to eq(final_positions)
        expect(rock.falling?).to eq(true)
      end
      it "doesn't move to the right" do
        rock.move!(:>, shaft)
        expect(rock.positions).to eq(final_positions)
        expect(rock.falling?).to eq(true)
      end
    end

    context "clash with rock to the sides, then falls over a rock" do
      let(:rock) { Rock.new([2, 1], 0) }
      let(:shaft) do
        instance_double("Shaft", width: 6, occupied_positions: [[2, 0], [2, 5], [1, 1]])
      end
      let(:final_positions) { [[2, 1], [2, 2], [2, 3], [2, 4]] }

      it "doesn't move to the left" do
        rock.move!(:<, shaft)
        expect(rock.positions).to eq(final_positions)
        expect(rock.falling?).to eq(false)
      end
      it "doesn't move to the right" do
        rock.move!(:>, shaft)
        expect(rock.positions).to eq(final_positions)
        expect(rock.falling?).to eq(false)
      end
    end
  end
end
