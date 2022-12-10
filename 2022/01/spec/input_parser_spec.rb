describe InputParser do
  it "parses a single elve, single item input" do
    input = "1000"
    output = InputParser.parse(input)
    expect(output).to eq([[1000]])
  end

  it "parses a single elve, multiple item input" do
    input = "1000\n2000\n3000"
    output = InputParser.parse(input)
    expect(output).to eq([[1000, 2000, 3000]])
  end

  it "parses a multi-elve, multi-item input" do
    input = "1000\n2000\n\n50\n20\n300"
    output = InputParser.parse(input)
    expect(output).to eq([[1000, 2000], [50, 20, 300]])
  end
end
