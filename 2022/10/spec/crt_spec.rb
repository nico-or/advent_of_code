describe CRT do
  context "large sample input" do
    let(:crt) do
      cpu = CPU.from_file("./spec/fixtures/large.txt")
      CRT.new(cpu.history)
    end

    it "draws the sample message" do
      sample = <<~MSG
        ##..##..##..##..##..##..##..##..##..##..
        ###...###...###...###...###...###...###.
        ####....####....####....####....####....
        #####.....#####.....#####.....#####.....
        ######......######......######......####
        #######.......#######.......#######.....
      MSG

      expect(crt.message).to eq(sample)
    end
  end
end
