require './path'

class Schedule

  attr_accessor :towns, :paths, :data, :distance, :shortest_route, :count_of_routes

  def initialize
    @towns = load_data  # populate data structures with file data
    @constraint = {
        :nil    => '# return all routes',
        :max    => '#find all up to a max of n hops',
        :exact  => '#find routes of exactly n hops'
    }
  end

  def shortest_route first, last
    0
  end

  def distance route
    0
  end

  def find_all_routes first, last
    #TODO
    [["route","hops"],["route","hops"]]
  end

  def count_of_hops first, last
    (find_all_routes first, last).length
  end

  def count_of_routes first, last, results = nil, count = nil
    if (results) then

    end
    find_all_routes(first, last).length #add filter that specifies exact
  end

end

def load_data

  @adjacency_list = Hash.new
  @paths = []

  def init_list
    @obj.each {|item|
      item.strip!
      @adjacency_list[item.split(//,3)[0]] = Hash.new
    }
  end

  def parse_data
    @obj.each do |path|
      path_data = path.split(//,3)
      add_path path_data[0], path_data[1], path_data[2]
    end
  end

  def add_path start, destination, distance
    path = Path.new
    path.add start, destination, distance
    @paths.push(path)
  end

  @obj = read_graph_data
  init_list
  parse_data

  @adjacency_list
end

def is_stop? stop
  @towns[stop]
end

def read_graph_data
  f = File.new 'spec/graph_data.txt'
  @obj = f.gets
  f.close
  puts 'the following schedule was loaded: ', @obj.to_s
  @obj = @obj.split(/,\ */)
end

=begin
  def ldap_get(base_dn, filter, scope = nil, attrs = nil)
  binding.Pry
=end
