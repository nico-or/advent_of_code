=begin
 54321012345
4............
3.....#......
2....###.....
1...#####....
0..###S###...
1...#####....
2....###.....
3.....B......
4............

range = 3
=end

describe Reading do
  let(:sensor_position) { [0, 0] }
  let(:beacon_position) { [0, 3] }
  let(:reading) { Reading.new(*sensor_position, *beacon_position) }

  describe "#in_range?" do
    it "returns false for a position out of range" do
      position = [4, 0]
      expect(reading.in_range?(position)).to eq(false)
      position = [1, 3]
      expect(reading.in_range?(position)).to eq(false)
    end
    it "returns true for a position in range" do
      position = [0, 0]
      expect(reading.in_range?(position)).to eq(true)
      position = [0, 3]
      expect(reading.in_range?(position)).to eq(true)
      position = [2, 1]
      expect(reading.in_range?(position)).to eq(true)
    end
  end

  describe "#scanned_at_y" do
    it "returns [] for a position out of range" do
      y_reading = 4
      expect(reading.scanned_at_y(y_reading)).to eq([])
    end
    it "returns 1 position for a position in the edge of the range" do
      y_reading = 3
      position_count = reading.scanned_at_y(y_reading).count
      expect(position_count).to eq(1)
    end
    it "returns (1+range*2) for a position crossing the sensor position" do
      y_reading = 0
      position_count = reading.scanned_at_y(y_reading).count
      expect(position_count).to eq(reading.range * 2 + 1)
    end
  end

  describe "#frontier_positions" do
    it "returns the 16 positions adjacent to the sensor range" do
      pos_sample = [
        [4, 0], [0, 4],
        [2, 2],
        [1, 3], [-1, -3],
      ]

      positions = reading.frontier_positions

      expect(positions.uniq.count).to eq(16)
      expect(positions).to include(*pos_sample)
    end
  end
end
