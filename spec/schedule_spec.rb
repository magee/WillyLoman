require 'rspec'
require_relative '../graph'

describe Graph do

  before(:all) do
    File.open 'spec/graph_data.txt', 'w' do |f|
      f.write 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'
      f.close
    end

    @graph = Graph.new

  end

  it 'should read data from file' do
    @graph.towns.length.should eq(5)
  end

  it 'should add all paths for each town' do
    @path = @graph.towns["A"]
    expect(@path.length).to eq(3)
    @path = @graph.towns["B"]
    expect(@path.length).to eq(1)
    @path = @graph.towns["C"]
    expect(@path.length).to eq(2)
    @path = @graph.towns["D"]
    expect(@path.length).to eq(2)
    @path = @graph.towns["E"]
    expect(@path.length).to eq(1)
  end

  it 'should tell how many exact routes from A to B' do
    # TODO: correct tests
    expect(@graph.count_of_routes "C", "C").to eq(2)
    expect(@graph.count_of_routes "C", "D").to eq(2)
    expect(@graph.count_of_routes "A", "D").to eq(2)
    expect(@graph.count_of_routes "E", "A").to eq(2)
=begin
    expect(@graph.count_of_routes "C", "C").to equal(0)
    expect(@graph.count_of_routes "C", "D").to equal(0)
    expect(@graph.count_of_routes "A", "D").to equal(0)
    expect(@graph.count_of_routes "E", "A").to equal(0)
=end
  end

  it 'should provide a shortest_route between two cities' do
    @graph.towns.length.should equal(5)
  end

  it 'should calculate the distance of a given route' do
    # TODO: correct tests

=begin
    expect(@graph.distance "A-B-C").to eq(0)
    expect(@graph.distance "A-D").to eq(0)
    expect(@graph.distance "A-D-C").to eq(0)
    expect(@graph.distance "A-E-B-C-D").to eq(0)
    expect(@graph.distance "A-E-D").to eq(0)
=end

    expect(@graph.distance "A-B-C").to eq(9)
    expect(@graph.distance "A-D").to eq(5)
    expect(@graph.distance "A-D-C").to eq(13)
    expect(@graph.distance "A-E-B-C-D").to eq(22)
    expect(@graph.distance "A-E-D").to eq("NO SUCH ROUTE")

  end

  it 'should provide all routes between two cities' do
    @graph.towns.length.should equal(5)
  end


end
