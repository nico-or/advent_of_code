describe Point do
  let(:point) { Point.new("0,1,2") }

  describe "#position" do
    it "returns an array with the point coordinatines" do
      expect(point.coordinates).to eq([0, 1, 2])
    end
  end

  describe "#adjacent_coordinates" do
    it "returns the 6 adjacent coordinates" do
      expected = [
        [-1, 1, 2], [1, 1, 2],
        [0, 0, 2], [0, 2, 2],
        [0, 1, 1], [0, 1, 3],
      ].sort

      coordinates = point.adjacent_coordinates.sort

      expect(coordinates.count).to eq(6)
      expect(coordinates).to eq(expected)
    end
  end

  describe ".from_coordinates" do
    it "creates a point from an array" do
      coordinates = [3, 5, 7]

      point = Point.from_coordinates(coordinates)

      expect(point.coordinates).to eq(coordinates)
    end
  end
end
