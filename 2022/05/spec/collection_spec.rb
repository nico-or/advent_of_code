describe Collection do
  let(:collection) { Collection.from_file("./spec/fixtures/input.txt") }

  describe ".from_file" do
    it "creates the correct collection" do
      sample = Collection.new(3)
      sample[0] << "Z" << "N"
      sample[1] << "M" << "C" << "D"
      sample[2] << "P"

      expect(collection).to eq(sample)
    end
  end

  describe "#code" do
    it "returns the correct concatenation of crate tops" do
      expect(collection.code).to eq("NDP")
    end
  end

  describe "#move!" do
    it "moves one crate to another stack" do
      instruction = "move 1 from 2 to 1"
      collection.move!(instruction)

      expect(collection[0]).to eq(Stack.new("ZND"))
      expect(collection[1]).to eq(Stack.new("MC"))
    end

    it "moves two crates to another stack" do
      instruction = "move 2 from 2 to 1"
      collection.move!(instruction)

      expect(collection[0]).to eq(Stack.new("ZNDC"))
      expect(collection[1]).to eq(Stack.new("M"))
    end
  end
end
