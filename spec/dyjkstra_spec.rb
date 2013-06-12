require 'rspec'
require 'spec_helper'
require_relative '../dyjkstra'

describe Dyjkstra do

  before(:all) do
    new_graph = {"A"=>{"B"=>2,"D"=>5}}
    @path_finder = Dyjkstra.new new_graph, "adjacencyList"
  end

  it 'sets local variables on initialization' do
    expect(@path_finder.graph).to be_a(Hash)
    expect(@path_finder.graph.length).to eq(1)
  end

  it 'should respond to findShortest' do
    expect(@path_finder).to respond_to(:findShortest)
  end

end
