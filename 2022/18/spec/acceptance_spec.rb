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
    it "returns an exterior surface area of 10" do
      expect(droplet.exterior_surface_area).to eq(10)
    end
  end

  context "sample input" do
    let(:droplet) { droplet_from_file("sample.txt") }
    it "returns a surface area of 64" do
      expect(droplet.surface_area).to eq(64)
    end
    it "returns an exterior surface area of 58" do
      expect(droplet.exterior_surface_area).to eq(58)
    end
  end

  context "star with hole" do
    let(:droplet) do
      grid = Grid.new

      input = <<~TXT
        1,1,0
        0,1,1
        1,0,1
        2,1,1
        1,2,1
        1,1,2
      TXT

      input.lines.each do |line|
        grid << Point.new(line)
      end
      grid
    end

    it "returns a surface area of 36" do
      expect(droplet.surface_area).to eq(36)
    end
    it "returns an exterior surface area of 30" do
      expect(droplet.exterior_surface_area).to eq(30)
    end
  end

  context "star without hole" do
    let(:droplet) do
      grid = Grid.new

      input = <<~TXT
        1,1,0
        0,1,1
        1,0,1
        2,1,1
        1,2,1
        1,1,2
        1,1,1
      TXT

      input.lines.each do |line|
        grid << Point.new(line)
      end
      grid
    end

    it "returns a surface area of 30" do
      expect(droplet.surface_area).to eq(30)
    end
    it "returns an exterior surface area of 30" do
      expect(droplet.exterior_surface_area).to eq(30)
    end
  end
end
