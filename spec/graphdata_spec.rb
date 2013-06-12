require 'rspec'
require 'spec_helper'
require_relative '../graphdata'

describe GraphData do

  before(:all) do

    # write standard data to test input files
    File.open 'spec/graph_data_1.txt', 'w' do |f|
      f.write 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'
      f.close
    end

    File.open 'spec/graph_data_2.txt', 'w' do |f|
      f.write 'AB1, AI4, AH5, HG1, IG3, BC2, IC7, GJ6, GF6, CJ2, CD8, JE4, FE2, DE3'
      f.close
    end

    File.open 'spec/graph_data_3.txt', 'w' do |f|
      f.write 'AB1,  "AI4", AH5, \'HG1\', IG3, BC2,IC7,GJ6, GF6, CJ2, CD8, JE4, FE2, DE3'
      f.close
    end

  end

  it 'responds to importCSV' do
    GraphData.should respond_to(:importCSV)
  end

  it 'responds to adjacencyList' do
    GraphData.should respond_to(:adjacencyList)
  end

  it 'reads data from file specified' do
    expect(GraphData.importCSV).to match_array(["2EC", "3BE", "4CB", "5BA", "5DA", "6ED", "7EA", "8CD", "8DC"])
    expect(GraphData.importCSV 'spec/graph_data_1.txt').to match_array(["2EC", "3BE", "4CB", "5BA", "5DA", "6ED", "7EA", "8CD", "8DC"])
    expect(GraphData.importCSV 'spec/graph_data_2.txt').to match_array(["1BA", "1GH", "2CB", "2EF", "2JC", "3ED", "3GI", "4IA", "4EJ", "5HA", "6FG", "6JG", "7CI", "8DC"])
    expect(GraphData.importCSV 'spec/graph_data_3.txt').to match_array(["1BA", "1GH", "2CB", "2EF", "2JC", "3ED", "3GI", "4IA", "4EJ", "5HA", "6FG", "6JG", "7CI", "8DC"])
  end

  it 'returns a populated adjacencyList' do
    list = GraphData.adjacencyList GraphData.pathData
    expect(list).to be_a(Hash)

    list.each do |entry|
      expect(entry[0]).to be_a(String)    #key
      expect(entry[0].length).to eq(1)    #one character length keys
      expect(entry[1]).to be_a(Hash)      #value is hash of neighbors
    end

    expect(list["A"].to_s).to eq('{"B"=>5, "D"=>5, "E"=>7}')
    expect(list["C"].to_s).to eq('{"E"=>2, "D"=>8}')
    expect(list["E"].to_s).to eq('{"B"=>3}')
  end

  it 'returns an initialized adjacencyMatrix' do
    list = Hash.new
    list = GraphData.initializeSquareMatrix (GraphData.getUniqueTowns GraphData.pathData)
    expect(list).to be_a(Hash)
    list.each do |entry|
      expect(entry[1]).to be_a(Hash)
    end
    expect(list["A"].to_s).to eq('{"C"=>nil, "E"=>nil, "B"=>nil, "A"=>nil, "D"=>nil}')
  end

  it 'returns a populated adjacencyMatrix' do
    list = Hash.new
    list = GraphData.adjacencyMatrix GraphData.pathData

    expect(list["A"].to_s).to eq('{"C"=>nil, "E"=>7, "B"=>5, "A"=>nil, "D"=>5}')
    expect(list["C"].to_s).to eq('{"C"=>nil, "E"=>2, "B"=>nil, "A"=>nil, "D"=>8}')
    expect(list["E"].to_s).to eq('{"C"=>nil, "E"=>nil, "B"=>3, "A"=>nil, "D"=>nil}')
  end

  it 'returns the correct unique towns' do
    towns = GraphData.getUniqueTowns GraphData.pathData
    expect(towns).to match_array(["C", "E", "B", "A", "D"])
    expect(towns.length).to eq(5)
  end

  it 'parses input data correctly' do
    list = Hash.new
    puts "pathdata: ", GraphData.pathData.to_s
    puts "list: ", (GraphData.adjacencyList GraphData.pathData).to_s

    list = GraphData.adjacencyList GraphData.pathData
    list.length.should equal(5)

    expect(list["A"].to_s).to eq('{"B"=>5, "D"=>5, "E"=>7}')
    expect(list["C"].to_s).to eq('{"E"=>2, "D"=>8}')
  end
end

