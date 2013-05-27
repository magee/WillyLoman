require 'csv'
require './path'

=begin
  def method_missing name, *args, &block
  end
=end

class Schedule

  attr_accessor :towns, :paths, :data

  @data = Hash.new      # holds raw graph data from text file
  @paths                # used to define nodes in town neighbor arrays

  def initialize
    @towns = Hash.new   # towns are graph vertices
    load_data           # read graph data from file
    init_towns          # populate towns obj with unique nodes in graph
    add_paths
  end

  def load_data
    f = File.new('spec/graph_data.txt')
    @data = CSV.parse_line(f.read)
    f.close
    puts 'the following schedule was loaded: ', @data.to_s
    @data
  end

  def parse_input
    @data = CSV.parse_line(@data)
    puts @data.is_a?(Array)
    @data
  end

  def init_towns
    @data.each {|town|
      town.strip!
      @towns[town.split(//,3)[0]] = Hash.new
    }
  end

  def add_paths
    true
  end

=begin
  class Town
    def initialize(name)
      @towns.name = name
      @routes = {}
    end

  end
=end
=begin
    binding.Pry
=end

end


