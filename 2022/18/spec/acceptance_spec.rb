def droplet_from_file(filename)
  grid = Grid.new
  File.readlines(filename, chomp: true)
      .map { |line| grid << Point.new(line) }
  grid
end

describe "acceptance" do
  context "mini input" do
    let(:droplet) { droplet_from_file("mini.txt") }
    it "returns a surface area of 10" do
      expect(droplet.surface_area).to eq(10)
    end
  end

  context "sample input" do
    let(:droplet) { droplet_from_file("sample.txt") }
    it "returns a surface area of 64" do
      expect(droplet.surface_area).to eq(64)
    end
  end
end
