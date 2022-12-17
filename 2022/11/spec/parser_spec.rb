describe Parser do
  include Parser

  describe "#find_integer" do
    it "parses a monkey name string" do
      string = "Monkey 0:"
      num = find_integer(string)
      expect(num).to eq(0)
    end
    it "parses a :+ operation string" do
      string = "  Operation: new = old + 6"
      num = find_integer(string)
      expect(num).to eq(6)
    end
    it "parses a :* operation string" do
      string = "  Operation: new = old * 19"
      num = find_integer(string)
      expect(num).to eq(19)
    end
    it "parses an test string" do
      string = "  Test: divisible by 13"
      num = find_integer(string)
      expect(num).to eq(13)
    end
    it "parses a monkey throw string" do
      string = "    If true: throw to monkey 2"
      num = find_integer(string)
      expect(num).to eq(2)
    end
  end

  describe "#operation" do
    it "parses an {old} * {other} string" do
      string = "  Operation: new = old * 19"
      operation = operation(string)
      result = operation.call(4)
      expect(result).to eq(19 * 4)
    end
    it "parses an {old} + {other} string" do
      string = "  Operation: new = old + 6"
      operation = operation(string)
      result = operation.call(13)
      expect(result).to eq(13 + 6)
    end
    it "parses an {old} * {old} string" do
      string = "  Operation: new = old * old"
      operation = operation(string)
      result = operation.call(13)
      expect(result).to eq(13 ** 2)
    end
  end

  describe "#test" do
    it "parses a divisible by {other} string" do
      string = "  Test: divisible by 13"
      test = test(string)
      expect(test.call(13)).to eq(true)
      expect(test.call(14)).to eq(false)
    end
  end

  describe "#find_all_integers" do
    it "parses an starting items string" do
      string = "  Starting items: 54, 65, 75, 74"
      integers = find_all_integers(string)
      expect(integers).to eq([54, 65, 75, 74])
    end
  end
end
