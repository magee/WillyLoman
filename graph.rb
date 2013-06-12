require './graphdata'
require './dyjkstra'

class Graph

  attr_accessor :towns, :data, :distance, :shortest_route, :count_of_routes, :number_of_towns

    @@towns = Hash.new

  def initialize
    @@towns = GraphData.adjacencyList (GraphData.importCSV 'spec/graph_data.txt')
  end

  def number_of_towns
    @@towns.length
  end

  def number_of_paths
    count_of_routes
  end

  def number_of_neighbors town
    @@towns[town].length
  end

  def shortest_route first, last
    finder = Dyjkstra.new @@towns, "adjacencyList"
    0
  end

  # accepts variable length routes as strings in form "A-B"
  # for one connection or "A-B-...-E" for an entire route
  def distance route
    total_distance = 0

    # repeat one time fewer than number of towns to capture count of edges/paths
    0.upto(route.length - 2) do |town|

      next_town = town + 1

      # if no route exists between two cities, return "NO SUCH ROUTE"
      if (@@towns[route[town]][route[next_town]]) then
        total_distance += @@towns[route[town]][route[next_town]]
      else
        total_distance = "NO SUCH ROUTE"
      end
    end

    total_distance
  end

  def all_routes_between first, last
    @routes = []
    path = []
    visited = {}
    @first = first
    @last = last

    def find_route first, last, path, visited
      path.push(first)
      visited[first] = true
      @route_found = false
      for key in @towns[first].each
        if key == last
          path.push(key)
          @route_found = true
        elsif key == first
          path = []
          continue              # evaluate next connected town
        else
          find_route key, last, path, visited
        end
      end
    end

    @routes
  end

  def count_of_stops first, last, count_type, threshold
    (find_all_routes first, last).length
  end

  # optimize by executing all_routes_between using results and count
  def count_of_routes first, last, results = nil, count = nil
    @constraint = {
      nil      => '# return all routes',
      "max"    => '#find all up to a max of n hops',
      "exact"  => '#find routes of exactly n hops'
    }

    if (@constraint[results]) then    # legitimate value for results parameter

    end

    map = all_routes_between first, last
    map.length
  end
end

