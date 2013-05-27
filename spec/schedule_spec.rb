require 'rspec'
require_relative '../schedule'

describe Schedule do

  before(:all) do
    @schedule = Schedule.new
    # add content here to write schedule data to file for testing
    File.open 'spec/graph_data.txt', 'w' do |f|
      f.write 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'
      f.close
    end
  end

  it 'should respond to load method' do
    @schedule.should respond_to(:load_data)
  end

  it 'should read data from file' do
    @schedule.data.length.should_not equal(0)
  end

  it 'should read all paths' do
    @schedule.data.length.should equal(9)
  end

  it 'should have 5 unique towns' do
    @schedule.towns.length.should equal(5)
  end

  it 'should create a path instance' do
    @schedule.add_path "A", "B", 7
    @schedule.paths.length.should_not equal(0)
  end
end
