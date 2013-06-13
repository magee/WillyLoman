require 'rspec'
require 'spec_helper'
require 'graphdata'
require_relative '../app'

describe App do

  it 'reads data from text file' do
    @graph = Graph.new
    @graph = GraphData.pathData
    expect(@graph.number_of_towns).to equal(5)
  end

end
