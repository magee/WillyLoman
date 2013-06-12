# module pulls graph data from external files, parses it and loads
# either an adjacency list or an adjacency matrix from the data
# per instructions - did not use CSV library
module GraphData

  attr_reader :getUniqueTowns, :adjacencyList, :adjacencyMatrix

  # returns multidimensional array of paths from text file
  def GraphData.pathData
    @pathData = GraphData.importCSV
  end

  # get file from external text file in 'spec/' folder returns
  # data array for "AB3, DC8" input formatted like ['AB3', 'DC8']
  def GraphData.importCSV file_name = "spec/graph_data.txt"
    f = File.new file_name
    data = f.gets
    f.close

    # remove quotes and spaces from input file and put into an array
    data = data.gsub(/['"\ ]+/, '').split(/,/)

    # user notification
    puts 'the following schedule was loaded: ', data.to_s

    # put the distance first for sorting
    data.each do |item|
      item.reverse!
    end

    # sorts array in asc order by path distances so lowest distance
    # paths are entered first in adjacency list value arrays
    GraphData.extractPathData data.sort
  end

  # converts array of path strings (i.e. ['AB3', 'DC8']) into a
  # multi-dimensional array like: [['A','B','3'],['D','C','8']]
  def GraphData.extractPathData data
    pathData = Array.new
    data.each {|item|
      item.strip!
      pathData.push(item.split(//,3))
    }
  end

  # data is an array of all paths read from a text file
  def GraphData.adjacencyList data
    adjacency_list = Hash.new

    data.each {|item|

      # add town to the list hash and add an empty hash as its inital value
      adjacency_list[item[2].upcase] ||= {}

      # if path hasn't been added, add it.  If it exists already and new
      # distance != existing write error to console.  Otherwise, it's
      # a benign duplicate
      if  !adjacency_list[item[2]][item[1]] then
           adjacency_list[item[2]][item[1]] = item[0].to_i
      else
        puts "error: ", adjacency_list[item[2]]
        # throw error - out of scope
      end
    }

    adjacency_list
  end

  # data is an array of all paths read from a text file
  def GraphData.adjacencyMatrix data

    adjacencyMatrix = Hash.new
    uniqueTowns = GraphData.getUniqueTowns data

    # example: data = ["2EC", "3BE", "4CB", "5BA", "5DA", "6ED", "7EA", "8CD", "8DC"]
    data.each {|item|


=begin
      if  !adjacencyMatrix[item[2]][item[1]] then
           adjacencyMatrix[item[2]][item[1]] = item[0].to_i
      else
        puts "error: ", adjacencyMatrix[item[2]]
        # throw error - out of scope
      end
=end
    }

    adjacencyMatrix = GraphData.initializeSquareMatrix uniqueTowns
    puts "init matrix: #{adjacencyMatrix.to_s}"
    temp = adjacencyMatrix

    #puts "final matrix: #{adjacencyMatrix.to_s}"
    adjacencyMatrix = GraphData.fillMatrix adjacencyMatrix, data

    temp

  end

  # learn the correct way of doing this so it can be inside
  # adjacency matrix method
  def GraphData.fillMatrix matrix, data
    data.each {|item|
      matrix[item[2]][item[1]] = item[0].to_i
    }
    matrix
  end

  def GraphData.initializeSquareMatrix nodeList
    matrix = Hash.new

    # see if can be done with less than O(n^2) complexity
    nodeList.sort.each {|rowNode|
      matrix[rowNode] = Hash.new
      nodeList.each {|columnNode|
        matrix[rowNode][columnNode] = nil
      }
    }

    matrix
  end

  def GraphData.getUniqueTowns data
    townList = Hash.new
    uniqueTowns = Array.new

    data.each {|item|
      # add town to the list hash and add an empty hash as its inital value
      townList[item[2].upcase] = true
    }

    townList.keys.each { |town|
      uniqueTowns.push(town)
    }
  end

end
