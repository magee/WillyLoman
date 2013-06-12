require 'rspec'
require 'spec_helper'
require_relative '../inputdata'

describe InputData do

  # to facilitating testing
  it 'allows programmatic submission of commands' do
    expect(InputData.setUserInput= '{"command"=>"distance", "start"=>"A-B", "route"=>["A", "B"]}').to eq('{"command"=>"distance", "start"=>"A-B", "route"=>["A", "B"]}')
    expect(InputData.setUserInput= '{"command"=>"distance", "start"=>"A-D-C-D", "route"=>["A", "D", "C", "D"]}').to eq('{"command"=>"distance", "start"=>"A-D-C-D", "route"=>["A", "D", "C", "D"]}')
  end

  it 'creates correct command object' do
    data = InputData.processInput "d a-b"
    expect(data).to eq({"command"=>"distance", "start"=>"A-B", "route"=>["A", "B"]})
    data = InputData.processInput "d a-b-c-d"
    expect(data).to eq({"command"=>"distance", "start"=>"A-B-C-D", "route"=>["A", "B", "C", "D"]})
    data = InputData.processInput "c c d"
    expect(data).to eq({"command"=>"count", "start"=>"C", "route"=>["C"], "terminus"=>"D"})
  end

  #TODO: add more input error testing
end
