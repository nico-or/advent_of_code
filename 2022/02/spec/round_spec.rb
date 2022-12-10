describe Round do
  describe "#result" do
    context "returns :win for" do
      it "rock vs paper" do
        expect(Round.new("A Z").result).to eq(:win)
      end
      it "paper vs scissors" do
        expect(Round.new("B Z").result).to eq(:win)
      end
      it "scissors vs rock" do
        expect(Round.new("C Z").result).to eq(:win)
      end
    end

    context "returns :draw for" do
      it "rock vs rock" do
        expect(Round.new("A Y").result).to eq(:draw)
      end
      it "paper vs paper" do
        expect(Round.new("B Y").result).to eq(:draw)
      end
      it "scissors vs scissors" do
        expect(Round.new("C Y").result).to eq(:draw)
      end
    end

    context "returns :lost for" do
      it "rock vs scissors" do
        expect(Round.new("A X").result).to eq(:lost)
      end
      it "paper vs rock" do
        expect(Round.new("B X").result).to eq(:lost)
      end
      it "scissors vs paper" do
        expect(Round.new("C X").result).to eq(:lost)
      end
    end
  end

  describe "#shape_score" do
    it "returns 1 for rock" do
      round = Round.new("A Y")
      expect(round.shape_score).to eq(1)
    end
    it "returns 2 for paper" do
      round = Round.new("B Y")
      expect(round.shape_score).to eq(2)
    end
    it "returns 3 for scissors" do
      round = Round.new("C Y")
      expect(round.shape_score).to eq(3)
    end
  end

  describe "#result_score" do
    it "returns 0 for :lost" do
      round = Round.new("A X")
      expect(round.result_score).to eq(0)
    end
    it "returns 3 for :draw" do
      round = Round.new("A Y")
      expect(round.result_score).to eq(3)
    end
    it "returns 6 for :win" do
      round = Round.new("A Z")
      expect(round.result_score).to eq(6)
    end
  end

  describe "#score" do
    it "returns 4 for rock and tie" do
      expect(Round.new("A Y").score).to eq(4)
    end
    it "returns 1 for paper and lost" do
      expect(Round.new("B X").score).to eq(1)
    end
    it "returns 7 for scissors and win" do
      expect(Round.new("C Z").score).to eq(7)
    end
  end

  describe "#resolve_round" do
    it "returns C for rock & lost" do
      expect(Round.new("A X").resolve_round).to eq("C")
    end
    it "returns A for rock & tie" do
      expect(Round.new("A Y").resolve_round).to eq("A")
    end
    it "returns B for rock & win" do
      expect(Round.new("A Z").resolve_round).to eq("B")
    end
  end
end
