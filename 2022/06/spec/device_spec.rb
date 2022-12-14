require "json"

describe Device do
  let(:device) { Device.new }

  describe "#packet_marker" do
    it do
      device.message = File.read("./spec/fixtures/input.txt")
      expect(device.packet_marker).to eq(7)
    end

    it do
      streams = File.open("./spec/fixtures/input.json") { JSON.load _1 }
      streams.each do |json|
        device.message = json["datastream"]
        marker = json["packet_marker"]
        expect(device.packet_marker).to eq(marker)
      end
    end
  end

  describe "#message_marker" do
    it do
      streams = File.open("./spec/fixtures/input.json") { JSON.load _1 }
      streams.each do |json|
        device.message = json["datastream"]
        marker = json["message_marker"]
        expect(device.message_marker).to eq(marker)
      end
    end
  end
end
