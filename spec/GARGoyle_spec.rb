require 'GARGoyle.rb'

RSpec.describe GARGoyle do
  before(:each) do
    @sequencer = GARGoyle::JobSequencer.new
  end

  it 'is an empty sequence' do
    expect(@sequencer.process({})).to eq([])
  end

  it 'has a sequence of one job' do
    expect(@sequencer.process(a: '')).to eq(['a'])
  end

  it 'has a sequence of three jobs' do
    expect(@sequencer.process(a: '', b: '', c: '')).to eq(%w[a b c])
  end

  it 'has a sequence of three jobs with a dependency' do
    expect(@sequencer.process(a: '', b: 'c', c: '')).to eq(%w[a c b])
  end

  it 'has a sequence of six jobs with chained dependencies' do
    expect(@sequencer.process(a: '', b: 'c', c: 'f', d: 'a', e: 'b', f: '')).to eq(%w[a f c b d e])
  end

  it 'has a sequence of three jobs and a circular dependency' do
    expect do
      @sequencer.process(a: '', b: '', c: 'c')
    end.to raise_error(StandardError, "Job and dependency can't be the same")
  end

  it 'has a sequence of six jobs with a circular dependency' do
    expect do
      @sequencer.process(a: '', b: 'c', c: 'f', d: 'a', e: '', f: 'b')
    end.to raise_error(StandardError, 'There was a circular job dependency')
  end
end
