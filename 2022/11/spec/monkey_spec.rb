describe Monkey do
  let(:monkey) do
    input = <<~MONKEY
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3
    MONKEY

    Monkey.new(input)
  end

  describe "#initialize" do
    describe "#number" do
      it { expect(monkey.number).to eq(0) }
    end

    describe "#items" do
      it { expect(monkey.items).to eq([79, 98]) }
    end

    describe "@operation" do
      let(:operation) { monkey.instance_variable_get(:@operation) }
      it { expect(operation).to be_a(Proc) }
    end

    describe "@divisor" do
      let(:divisor) { monkey.instance_variable_get(:@divisor) }
      it { expect(divisor).to be_an(Integer) }
    end
  end

  describe "#<<" do
    it "adds a new item to the monkey items" do
      monkey << 420
      expect(monkey.items).to eq([79, 98, 420])
    end
  end

  describe "#inspect_items!!" do
    let(:monkeys) do
      Array.new(6) do
        double("monkey",
               :<< => nil,
               :divisor => 1)
      end
    end

    before { monkey.inspect_items!(monkeys) }

    it "get rid of all its items" do
      expect(monkey.items).to eq([])
    end

    it "incrase inspected item count to 2" do
      expect(monkey.inspected_items).to eq(2)
    end
  end
end
