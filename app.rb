require './schedule'
require './path'

class App

  Schedule.send("public", :distance)

  @schedule = Schedule.new
  @answer

  def query_user

    prompt_user     # ask user what info she wants to receive
    parse_input     # process input and assign local variables appropriately

    case @command
      when 'd' || 'distance'
        if (@start) then
          if (!@terminus) then
            @route = @start.split(/-/)      #in this case @start is the route provided in form of 'A-D-E...'
            @answer = @schedule.distance @route
          else
            @answer = @schedule.distance [@start, @terminus]
          end
          puts @answer
        else
          throw_error
        end
      when 'c' || 'count'
        if (@start && @terminus) then
          if (count_type == "max" || count_type == "exact") then
            @answer = @schedule.count_of_hops @start, @terminus, count_type || nil, threshold || nil
          else
            puts "Invalid options. Valid entries are 'max', 'exact' or nothing.  You entered #{@query[3]}.\n\n"
          end
          puts @answer
        else
          throw_error
        end
      when 's' || 'shortest'
        if (@start && @terminus) then
          @answer = @schedule.shortest_route @query[1], @query[2]
          puts @answer
        else
          throw_error
        end
      else
        throw_error
    end

    puts "\n\nThank you for using the Railroad @Scheduler!"
  end

  def prompt_user
    puts "\n\nTrain @scheduler lets you find paths between cities, their distances and total hops.  \nGiven a city 'a' and a city 'b, available commands are: \n\n(d)istance a b\t\t\t\t(e.g.   'd e a' - distance from e to a -or- \n\t\t\t\t\t\t'distance c d' - distance from c to d)\n\n(d)istance <path>\t\t\t<path> is string in form of 'A-B-...-D' \n\n\t\t\t\t\t(e.g.   'd A-D-F' - distance from A to F through D)\n\n(s)hortest a b\t\t\t\t(e.g.   'shortest f c' - shortest route from f to c)\n\n(c)ount a b [exact n|max n]\t\t(e.g.   'count b c max 4' - count of routes from b to c \n\t\t\t\t\t\t with 4 or fewer stops -or- \n\n\t\t\t\t\t\t'c d a' - count of stops from d to a)\n\n"
    puts "What information would you like? "
  end

  def throw_error
    puts "Invalid command.  Please try again.\n\n"
  end

  def parse_input
    catch(:error) do
      @query = gets.chomp
      @query = @query.split(/,*\ */)

      if (@query[0]) then
        @command = @query[0].downcase
      else
        throw_error
        throw :error
      end

      if (@query[1]) then
        @start = @query[1].downcase
      else
        throw_error
        throw :error
      end

      if (@query[2]) then
        @terminus = @query[2].downcase
      else
        throw_error
        throw :error
      end

      if (@query[3] && !@query[4]) then
        throw_error
        throw :error
      end

      if (@query[3] && @query [4]) then
        count_type = @query[3].downcase
        threshold = @query[4]
      end
    end
  end
end

@go = App.new
@go.query_user

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
