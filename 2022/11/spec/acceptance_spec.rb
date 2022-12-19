describe "Acceptance" do
  let(:monkeys) { Monkey.from_file("./spec/fixtures/input.txt") }

  it "counts inspected items correctly after 1 round" do
    1.times { Monkey.round(monkeys) }

    solution = [2, 4, 3, 6]
    expect(monkeys.map(&:inspected_items)).to eq(solution)
  end

  it "counts inspected items correctly after 20 rounds" do
    20.times { Monkey.round(monkeys) }

    solution = [99, 97, 8, 103]

    expect(monkeys.map(&:inspected_items)).to eq(solution)
  end

  it "counts the inspected items correctly after 1_000 rounds" do
    1_000.times { Monkey.round(monkeys) }

    solution = [5_204, 4_792, 199, 5_192]
    expect(monkeys.map(&:inspected_items)).to eq(solution)
  end

  it "counts the inspected items correctly after 10_000 rounds" do
    10_000.times { Monkey.round(monkeys) }

    solution = [52_166, 47_830, 1_938, 52_013]
    expect(monkeys.map(&:inspected_items)).to eq(solution)
  end
end
