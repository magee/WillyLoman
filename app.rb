
require './graph'


class App

  @@graph ||= Graph.new
  @@graph.towns ||= {}

  @answer

  def query_user

    prompt_user     # ask user what info she wants to receive
    parse_input     # process input and assign local variables appropriately

    case @command
      when 'distance'
        # TODO modify regex to handle quotes
        @route = @start.split(/[-'"]/)      # @start is the route provided in form of 'A-D-E...'

        # remove empty element created if input provided in single or double quotes
        if (@route[0] == "") then @route.shift end

        @answer = @@graph.distance @route
      when 'count'
        @answer = @@graph.count_of_hops @start, @terminus, count_type || nil, threshold || nil
      when 'shortest'
        @answer = @@graph.shortest_route @query[1], @query[2]
      else
        puts "case statement error"
        throw_error
    end

    puts "\n\nThank you for using the Railroad Grapher!"
  end

  def prompt_user
    puts "\n\nTrain Grapher lets you find paths between cities, their distances and total hops.  \nGiven a city 'a' and a city 'b, available commands are: \n\n(d)istance <path>\t\t\t<path> is a route defined as 'A-B' for two directly connected \n\t\t\t\t\tcities or 'A-C-E-B' for a specific route from A to B \n\t\t\t\t\t(e.g.   'd A-D-F' - distance from A to F through D)\n\n(s)hortest a b\t\t\t\t(e.g.   'shortest f c' - shortest route from f to c)\n\n(c)ount a b [exact n|max n]\t\t(e.g.   'count b c max 4' - count of routes from b to c \n\t\t\t\t\t\t with 4 or fewer stops -or- \n\t\t\t\t\t\t'c d a' - count of stops from d to a)\n\n"
    puts "What information would you like? "
  end

  def throw_error
    puts "\n\nInvalid command.  Please try again.\n\n"
    throw :error
  end

  # Evaluates arguments passed, throws errors if they are incorrect.
  # Otherwise, assigns arguments to local variables
  def parse_input

    # defines permitted commands and converts shortcuts into full commands
    commands = {
      'd' => 'distance',
      'distance' => 'distance',
      'c' => 'count',
      'count' => 'count',
      's' => 'shortest',
      'shortest' => 'shortest'
    }

    catch(:error) do
      @query = gets.chomp
      # TODO fix regex to strip quotes
      @query = @query.split(/,*\ /)

      if (commands[@query[0].downcase]) then
        @command = commands[@query[0].downcase]
      else
        puts "command error"
        throw_error
      end

      # all supported commands require at least one argument
      if (@query[1]) then
        @start = @query[1].downcase
      else
        puts "first argument error"
        throw_error
      end

      # optional argument required for Count and Shortest but not for Distance
      if (@query[2]) then
        if @command == 'd' || @command == 'distance' then
          puts "extra argument for distance command"
          throw_error
        else
          @terminus = @query[2].downcase
        end
      elsif @command != 'd' && @command != 'distance' then
        puts "missing argument for command"
        throw_error
      end

      # @query[3] && @query[4] are optional
      if (@query[3] && @query[4]) then
        count_type = @query[3].downcase
        threshold = @query[4]

        if (count_type != "max" && count_type != "exact") then
          puts "Invalid options. Valid entries are 'max', 'exact' or nothing.  You entered #{@query[3]}.\n\n"
          throw :error
        end
      end

      # But if @query[3] is passed there must be a @query[4] value
      if (@query[3] && !@query[4]) then
        # if the third parameter (exact||max) is provided, the fourth must be also
        puts "a value is required when passing " + @query[3]
        throw_error
      end
    end
  end
end


@go = App.new
test = {
  'one'   => 1,
  'two'   => 2,
  'three' => 3,
  'four'  => 4
}
puts test.keys
puts test.values
catch(:error) do
#  @go.query_user
end



