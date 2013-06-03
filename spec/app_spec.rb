require 'rspec'
require_relative '../app'

describe App do

  before(:each) do
    File.open 'spec/graph_data.txt', 'w' do |f|
      f.write 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'
      f.close
    end

    @graph = Graph.new

  end

  it 'should read data from file' do
    @graph.towns.length.should_not equal(0)
  end

end