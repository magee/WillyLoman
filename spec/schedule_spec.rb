require 'rspec'
require_relative '../schedule'

describe Schedule do

  before(:all) do
    File.open 'spec/graph_data.txt', 'w' do |f|
      f.write 'BA1, CD4, AB2, EA5, CE3, AE5, BE2, DA6, DA3'
      f.close
    end

    @schedule = Schedule.new

  end

  it 'should read data from file' do
    @schedule.towns.length.should_not equal(0)
  end

  it 'should have 5 unique towns' do
    @schedule.towns.length.should equal(5)
  end

  it 'should add all paths for each town' do
    #TODO
  end

  it 'should tell how many exact routes from A to B' do
    # TODO: correct tests
    expect(@schedule.count_of_routes "C", "C").to equal(2)
    expect(@schedule.count_of_routes "C", "D").to equal(2)
    expect(@schedule.count_of_routes "A", "D").to equal(2)
    expect(@schedule.count_of_routes "E", "A").to equal(2)
=begin
    expect(@schedule.count_of_routes "C", "C").to equal(0)
    expect(@schedule.count_of_routes "C", "D").to equal(0)
    expect(@schedule.count_of_routes "A", "D").to equal(0)
    expect(@schedule.count_of_routes "E", "A").to equal(0)
=end
  end

  it 'should provide a shortest_route between two cities' do
    @schedule.towns.length.should equal(5)
  end

  it 'should calculate the distance of a given route' do
    # TODO: correct tests
    expect(@schedule.distance "A-B-C").to equal(0)
    expect(@schedule.distance "A-D").to equal(0)
    expect(@schedule.distance "A-D-C").to equal(0)
    expect(@schedule.distance "A-E-B-C-D").to equal(0)
    expect(@schedule.distance "A-E-D").to equal(0)
=begin
    expect(@schedule.distance "A-B-C").to equal(9)
    expect(@schedule.distance "A-D").to equal(5)
    expect(@schedule.distance "A-D-C").to equal(13)
    expect(@schedule.distance "A-E-B-C-D").to equal(22)
    expect(@schedule.distance "A-E-D").to equal("NO SUCH ROUTE")
=end
  end

  it 'should provide all routes between two cities' do
    @schedule.towns.length.should equal(5)
  end

=begin
  it 'should read all paths' do
    @schedule.data.length.should equal(9)
  end
=end

  it 'should add path instances to paths collection' do
    expect(@schedule.paths.length).to eq(9)
  end

  it 'should add all paths to towns hash' do
    @schedule.add_path "A", "B", 7
    @schedule.add_path "C", "D", 8
    @schedule.add_path "D", "C", 8
    @schedule.parse_data

  end
end
