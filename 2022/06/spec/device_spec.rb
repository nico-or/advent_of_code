require "json"

describe Device do
  describe ".marker" do
    it do
      stream = File.read("./spec/fixtures/input.txt")
      marker = Device.marker(stream)

      expect(marker).to eq(7)
    end

    it do
      streams = File.open("./spec/fixtures/input.json") { JSON.load _1 }
      streams.each do |json|
        datastream = json["datastream"]
        marker = json["marker"]
        expect(Device.marker(datastream)).to eq(marker)
      end
    end
  end
end
