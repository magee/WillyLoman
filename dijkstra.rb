# Implementation of Dijkstra algorithm for graph route finding
require './graphdata'
class Dijkstra

  attr_reader :structure, :getGraph

  def initialize graph, structure
    @graph ||= graph
    @dataStructure = structure
    @unvisited = initUnvisited
  end

  def getGraph
    @graph
  end

  def Dijkstra.getUnvisited
    @unvisited
  end

  # for testing
  def Dijkstra.setUnvisited arr
    @unvisited = arr
  end

  def findShortest start, target

    answer = nil

    @shortestPath = []
    @totalDistance = 0

    # begin with starting town and distance of 0
    currentTown = [start, 0]

    # Moves from nextStop to nextStop until all nodes have
    # been visited, target has been reached or coming to
    # a dead end
    if @dataStructure == "adjacencyList" then

      while !answer do
        if @unvisited.empty? || currentTown.empty? then
          answer = "NO SUCH ROUTE"
        elsif currentTown[0] == target then
          @totalDistance += currentTown[1]
          @shortestPath.push(target)
          answer = [@shortestPath.join("-"), @totalDistance]
        else
          @unvisited.delete(currentTown[0])
          @shortestPath.push(currentTown[0])
          @totalDistance += currentTown[1]
#          currentTown = nextStop currentTown[0], currentTown[1]
          currentTown = nextStop currentTown[0]
        end
      end
    elsif @dataStructure == "adjacencyMatrix" then
      # review existing code to see if it can be made more abstract to
      # handle both or write code to handle this possibility later
    else
      # throw error -- invalid data structure specified
    end

    answer
  end


  # examines all neighbor nodes, finds the closest, unvisited town
  # and returns
=begin
  def nextStop current, target, distance
    # initialize with infinity each iteration = no bad upper bounds
    shortestDist = 1.0/0
    nextTown = []

    # neighbor == ["X", 5] where "X" is a town & 5 is the distance to it
    @graph[current].each { |neighbor|

      # get the total path distance travelling to this neighbor
      neighborDist = distance + neighbor[1]

      # if neighbor hasn't been visited and distance is shorter than current
      if (@unvisited.include? neighbor[0]) && (shortestDist > neighborDist) then
        shortestDist = neighbor[1] = neighborDist
        nextTown = neighbor
      end
    }

    nextTown
  end
=end

  # reviews all neighbors for current town, finds the closest one that
  # has not already been visited.  If no such town exists, returns empty
  # array.  Path has come to a dead end.
  def nextStop current
    # initialize with infinity each iteration = no bad upper bounds
    shortestDist = 1.0/0
    nextTown = []

    # neighbor == ["X", 5] where "X" is a town & 5 is the distance to it
    # if neighbor hasn't been visited and distance is shorter than the
    # shortest found to date, return town info
    puts "@graph[current]: #{@graph[current]}"
    @graph[current].each { |neighbor|
      puts "neighbor: #{neighbor.to_s}"
      if (@unvisited.include? neighbor[0]) && (shortestDist > neighbor[1]) then
        shortestDist = neighbor[1]
        nextTown = neighbor
      end
    }

    nextTown
  end

  def initUnvisited
    # get list of towns and remove start town for unvisited list
    GraphData.getUniqueTowns GraphData.pathData
  end
end