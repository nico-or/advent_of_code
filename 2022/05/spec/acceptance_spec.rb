FILENAME = "./spec/fixtures/input.txt"

describe "Acceptance" do
  it do
    collection = Collection.from_file(FILENAME)
    parser = Parser.new(FILENAME)

    parser.instructions.each { collection.move!(_1) }

    expect(collection.code).to eq("MCD")
  end
end
