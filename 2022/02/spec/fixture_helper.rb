module Fixture
  def self.load(filename)
    File.read("./spec/fixtures/#{filename}.txt")
  end
end
