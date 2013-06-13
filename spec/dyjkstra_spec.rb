require 'rspec'
require 'spec_helper'
require_relative '../graphdata'
require_relative '../dijkstra'

describe Dijkstra do

  before(:all) do
    graph = GraphData.adjacencyList (GraphData.importCSV 'spec/graph_data.txt')
    @finder = Dijkstra.new graph, "adjacencyList"
  end

  it 'sets local variables on initialization' do
    puts "finder.getGraph: #{@finder.getGraph}"
    expect(@finder.getGraph).to be_a(Hash)
    expect(@finder.getGraph.length).to eq(5)
  end

  it 'returns correct unvisited array' do
    expect(@finder.findShortest "A", "C").to match_array(["A-B-C", 9])
  end

  it 'responds to findShortest' do
    expect(@finder).to respond_to(:findShortest)
  end

  it 'returns correct shortest paths' do
    expect(@finder.findShortest "A", "C").to eq(9)
    expect(@finder.findShortest "B", "B").to eq(9)
  end

  it 'returns correct next stop' do
    expect(@finder.nextStop "A").to match_array(["B", 5])
  end

end
