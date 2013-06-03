class Graph

  attr_accessor :towns, :data, :distance, :shortest_route, :count_of_routes

    @@towns ||= Hash.new

  def initialize
    @@towns = load_data  # populate data structures with file data
  end

  def shortest_route first, last
    # Djykstra's algorithm
    0
  end

  # accepts variable length routes as strings in form "A-B"
  # for one connection or "A-B-...-E" for an entire route
  def distance route
    answer = 0
    path = route

    # repeat one time fewer than number of towns to capture path segments
    0.upto(path.length - 2) do |town|
      next_town = town + 1
      segment = path[town] + "-" + path[next_town]

      # if no route exists between two cities, return "NO SUCH ROUTE"
      if (@@towns[path[town]][path[next_town]]) then
        answer += @@towns[path[town]][path[next_town]]
      else
        answer = "NO SUCH ROUTE"
      end
    end

    answer
  end

  def find_all_routes first, last
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
=begin
          if @route_found then
            @routes.push @path
#            break                # recurse to find additional paths
          end
=end
    end

    @routes
  end

  def count_of_hops first, last
    (find_all_routes first, last).length
  end


  def count_of_routes first, last, results = nil, count = nil
    @constraint = {
      :nil    => '# return all routes',
      :max    => '#find all up to a max of n hops',
      :exact  => '#find routes of exactly n hops'
    }

    if (@constraint[results]) then    # legitimate value for results parameter

    end
    find_all_routes(first, last).length #add filter that specifies exact
  end

  # Reads graph data.  Splits each path into components and adds towns as keys
  # with empty hashs as values then inputs file data into the @towns hash.
  # Duplicate paths should not exist.  In the event of duplicate path definitions
  # with different distance values, final path added "wins".
  def load_data

    @adjacency_list = Hash.new
    @obj = read_graph_data  # @obj - contents of external graph data file

    @obj.each {|item|
      path_data = item.split(//,3)
      @adjacency_list[path_data[0]] = Hash.new
  #    @adjacency_list[path_data[0]][path_data[1]] = path_data[2]
    }

    @adjacency_list = parse_data
  end

  # reads hard-coded file as source of graph data
  def read_graph_data
    f = File.new 'spec/graph_data.txt'
    @obj = f.gets
    f.close

    # show user confirmation of schedule imported
    puts 'the following schedule was loaded: ', @obj.to_s
    @obj = @obj.split(/,\ */)
  end

  def parse_data
    @obj.each {|item|
      item.strip!
      path_data = item.split(//,3)

      # add town to the list hash and add an empty hash as its inital value
      if (!@adjacency_list[path_data[0]]) then
        @adjacency_list[path_data[0]] = Hash.new
      end

      # if path hasn't been added, add it.  If it exists already and new
      # distance != existing throw error - out of scope.  Otherwise, it's
      # a benign duplicate
      if    (!@adjacency_list[path_data[0][path_data[1]]]) then
              @adjacency_list[path_data[0]][path_data[1]]  = path_data[2].to_i
      elsif ( @adjacency_list[path_data[0]][path_data[1]] != path_data[2]) then
        puts "error: ", @adjacency_list[path_data[0]]
            #throw error
      end
    }

    @adjacency_list
  end

end

