describe "Acceptance" do
  let(:monkeys) do
    input = File.read("./spec/fixtures/input.txt")
    input.split("\n\n").map { Monkey.new _1 }
  end

  it "solves 1 round correctly" do
    1.times { round(monkeys) }

    solution = [
      [20, 23, 27, 26],
      [2080, 25, 167, 207, 401, 1046],
      [],
      [],
    ]
    expect(monkeys.map(&:items)).to eq(solution)
  end

  it "solves 2 rounds correctly" do
    2.times { round(monkeys) }

    solution = [
      [695, 10, 71, 135, 350],
      [43, 49, 58, 55, 362],
      [],
      [],
    ]
    expect(monkeys.map(&:items)).to eq(solution)
  end

  it "solves 20 rounds correctly" do
    20.times { round(monkeys) }

    solution = [
      [10, 12, 14, 26, 34],
      [245, 93, 53, 199, 115],
      [],
      [],
    ]

    expect(monkeys.map(&:items)).to eq(solution)
  end

  it "counts the inspected items correctly after 20 rounds" do
    20.times { round(monkeys) }

    item_count = monkeys.map(&:inspected_items)
    monkey_businnes = item_count.max(2).reduce(1, :*)

    solution = [101, 95, 7, 105]

    expect(item_count).to eq(solution)
    expect(monkey_businnes).to eq(10605)
  end
end
