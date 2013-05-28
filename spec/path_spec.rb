require 'rspec'
require_relative '../path'

describe Path do

  before(:all) do
    @path = Path.new
    @path.add "A", "B", 7
  end

  it 'should have a start, terminus and distance' do
    expect(@path.start).to eq("A")
    expect(@path.terminus).to eq("B")
    expect(@path.distance).to eq(7)
  end

end
