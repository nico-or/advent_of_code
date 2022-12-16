describe "Acceptance" do
  let(:cpu) { CPU.new }

  context "small.txt" do
    let(:cpu) { CPU.from_file("./spec/fixtures/small.txt") }

    it do
      cpu.noop! # to allows the 6th cycle to add the last addx

      expect(cpu[1].value).to eq(1)
      expect(cpu[2].value).to eq(1)
      expect(cpu[3].value).to eq(1)
      expect(cpu[4].value).to eq(4)
      expect(cpu[5].value).to eq(4)
      expect(cpu[6].value).to eq(-1)
    end
  end

  context "large.txt" do
    let(:cpu) { CPU.from_file("./spec/fixtures/large.txt") }

    it do
      expect(cpu[20].signal_strength).to eq(420)
      expect(cpu[60].signal_strength).to eq(1140)
      expect(cpu[100].signal_strength).to eq(1800)
      expect(cpu[140].signal_strength).to eq(2940)
      expect(cpu[180].signal_strength).to eq(2880)
      expect(cpu[220].signal_strength).to eq(3960)
    end
  end

  it "returns correct signal strength sum" do
  end
end
