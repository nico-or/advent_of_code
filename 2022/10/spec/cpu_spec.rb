describe CPU do
  let(:cpu) { CPU.new }

  describe "#noop" do
    it "adds a new cycle and preserves the register value" do
      cpu.noop!

      last_cycle = cpu.last

      expect(last_cycle.number).to eq(1)
      expect(last_cycle.value).to eq(1)
    end
  end

  describe "#addx" do
    it "single addx" do
      cpu.addx!(5)
      3.times { cpu.noop! }

      cycles = cpu.history

      expect(cycles[0].number).to eq(1)
      expect(cycles[0].value).to eq(1)

      expect(cycles[1].number).to eq(2)
      expect(cycles[1].value).to eq(1)

      expect(cycles[2].number).to eq(3)
      expect(cycles[2].value).to eq(6)
    end
  end

  describe "#execute!" do
    it "executes noop method" do
      instruction = "noop\n"

      expect(cpu).to receive(:noop!)

      cpu.execute!(instruction)
    end
    it "executes addx method" do
      instruction = "addx -5\n"

      expect(cpu).to receive(:addx!).with(-5)

      cpu.execute!(instruction)
    end
  end

  describe "#[]" do
    it "returns the cycle based of the arg number" do
      5.times { cpu.noop! }

      cycle = cpu[2]
      expect(cycle.number).to eq(2)
    end
  end
end
