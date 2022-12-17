describe Monkey do
  describe "#initialize" do
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

    describe "@test" do
      let(:test) { monkey.instance_variable_get(:@test) }
      it { expect(test).to be_a(Proc) }
    end

    describe "#<<" do
      it "adds a new item to the monkey items" do
        monkey << 420
        expect(monkey.items).to eq([79, 98, 420])
      end
    end

    describe "#inspect_items!!" do
      let(:monkeys) do
        class Array
          def items
            self
          end
        end

        Array.new(6) { Array.new }
      end

      before { monkey.inspect_items!(monkeys) }

      it "get rid of all its items" do
        expect(monkey.items).to eq([])
      end

      it "gives the items to monkeys 2 or 3" do
        expect(monkeys[2].items).to eq([])
        expect(monkeys[3].items).to eq([500, 620])
      end

      it "incrase inspected item count to 2" do
        expect(monkey.inspected_items).to eq(2)
      end
    end
  end
end
