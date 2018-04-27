RSpec.describe GARGoyle do
  it "is an empty sequence" do
    sequencer = GARGoyle::JobSequencer.new
    expect(sequencer.process({})).to eq([])
  end

  it "is has a sequence of one job" do
    sequencer = GARGoyle::JobSequencer.new
    expect(sequencer.process(a: '')).to eq(['a'])
  end

  it "is has a sequence of three jobs" do
    sequencer = GARGoyle::JobSequencer.new
    expect(sequencer.process(a: '', b: '', c: '')).to eq(%w[a b c])
  end
end
