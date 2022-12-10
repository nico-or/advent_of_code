describe Game do
  describe "#score" do
    it "returns the total game score" do
      game = Game.new(Fixture.load("input"))
      expect(game.score).to eq(15)
    end
  end
end
