require 'rspec'
require 'spec_helper'
require_relative '../graphdata'
require_relative '../graph'

describe Graph do

  before(:all) do
    @graph = Graph.new
  end

  it 'reads data from text file' do
    expect(@graph.number_of_towns).to equal(5)
  end

  it 'reads data from file' do
    expect(@graph.number_of_towns).to equal(5)
  end

  it 'adds all paths for each town' do
    @path = @graph.number_of_neighbors "A"
    expect(@path).to eq(3)

    @path = @graph.number_of_neighbors "B"
    expect(@path).to eq(1)

    @path = @graph.number_of_neighbors "C"
    expect(@path).to eq(2)

    @path = @graph.number_of_neighbors "D"
    expect(@path).to eq(2)

    @path = @graph.number_of_neighbors "E"
    expect(@path).to eq(1)
  end

  it 'calculates the distance of a given route' do
    expect(@graph.distance ["A", "B", "C"]).to eq(9)
    expect(@graph.distance ["A", "D"]).to eq(5)
    expect(@graph.distance ["A", "D", "C"]).to eq(13)
    expect(@graph.distance ["A", "E", "B", "C", "D"]).to eq(22)
    expect(@graph.distance ["A", "E", "D"]).to eq("NO SUCH ROUTE")

  end

=begin


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
# =end
#   end

#   it 'provides the shortest_route between two cities' do
#     @graph.towns.length.should equal(5)
#   end


  # it 'provides all routes between two cities' do
  #   @graph.towns.length.should equal(5)
  # end

end
