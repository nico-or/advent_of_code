describe "Acceptance" do
  let(:head) { Head.new }

  it do
    instructions = File.read("./spec/fixtures/input.txt")

    instructions.lines.each do |instruction|
      head.move(instruction)
    end

    visited_points = head.tail.memory

    expect(visited_points.uniq(&:to_s).count).to eq(13)
  end
end
