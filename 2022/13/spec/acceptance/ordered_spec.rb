describe "acceptance" do
  it do
    left = [1, 1, 3, 1, 1]
    right = [1, 1, 5, 1, 1]
    ordered = true
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = [[1], [2, 3, 4]]
    right = [[1], 4]
    ordered = true
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = [9]
    right = [[8, 7, 6]]
    ordered = false
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = [[4, 4], 4, 4]
    right = [[4, 4], 4, 4, 4]
    ordered = true
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = [7, 7, 7, 7]
    right = [7, 7, 7]
    ordered = false
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = []
    right = [3]
    ordered = true
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = [[[]]]
    right = [[]]
    ordered = false
    expect(ordered?(left, right)).to eq(ordered)
  end
  it do
    left = [1, [2, [3, [4, [5, 6, 7]]]], 8, 9]
    right = [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]
    ordered = false
    expect(ordered?(left, right)).to eq(ordered)
  end
end
