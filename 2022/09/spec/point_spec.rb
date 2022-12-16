describe Point do
  let(:point) { Point.new }

  describe "#initialize" do
    it { expect(point.x).to eq(0) }
    it { expect(point.y).to eq(0) }
  end

  describe "attr_accessors" do
    it do
      point.x += 1
      expect(point.x).to eq(1)
    end
    it do
      point.y -= 1
      expect(point.y).to eq(-1)
    end
  end

  describe "#distance" do
    it do
      other = Point.new
      expect(point.distance(other)).to eq(0)
    end

    it do
      other = Point.new(0, 1)
      expect(point.distance(other)).to eq(1)
    end

    it do
      other = Point.new(1, 1)
      expect(point.distance(other)).to eq(Math.sqrt(2))
    end
  end

  describe "#==" do
    it "true for point with same coordinates" do
      other = Point.new(0, 0)
      expect(point).to eq(other)
    end
    it "true for point in diferent coordinates" do
      other = Point.new(0, 1)
      expect(point).to_not eq(other)
    end
    it "works with arrays" do
      expect(Point.new(0, 0)).to eq([0, 0])
      expect(Point.new(-1, 0)).to eq([-1, 0])
      expect(Point.new(0, 2)).to eq([0, 2])
    end
    it "works with array of Points" do
      first = [Point.new(), Point.new(1, 2)]
      second = [Point.new(), Point.new(1, 2)]

      expect(first).to eq(second)
    end
    it "works with array of Points and array of integers" do
      first = [Point.new(), Point.new(1, 2)]
      second = [[0, 0], [1, 2]]

      expect(first).to eq(second)
    end
  end
end
