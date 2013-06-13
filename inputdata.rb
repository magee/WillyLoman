module InputData

  attr_reader :userInput

  # TODO: make error handling more seamless
  # informal error handling for exercise
  def InputData.throw_error
    puts "\n\nInvalid command.  Please try again.\n\n"
    throw :error
  end

  # only used for testing right now
  def InputData.setUserInput=(str)
    @userInput = str
  end

  # Evaluates arguments passed, throws errors if they are incorrect.
  # Otherwise, assigns arguments to local variables
  def InputData.userInput
    catch(:error) do
      puts "\n\nTrain Grapher lets you find paths between cities, their distances and total hops.  \nGiven a city 'a' and a city 'b, available commands are: \n\n(d)istance <path>\t\t\t<path> is a route defined as 'A-B' for two directly connected \n\t\t\t\t\tcities or 'A-C-E-B' for a specific route from A to B \n\t\t\t\t\t(e.g.   'd A-D-F' - distance from A to F through D)\n\n(s)hortest a b\t\t\t\t(e.g.   'shortest f c' - shortest route from f to c)\n\n(c)ount a b [exact n|max n]\t\t(e.g.   'count b c max 4' - count of routes from b to c \n\t\t\t\t\t\t with 4 or fewer stops -or- \n\t\t\t\t\t\t'c d a' - count of stops from d to a)\n\n"
      puts "What information would you like? "

      @query = gets.chomp
      @userInput = InputData.processInput @query
    end

    @userInput
  end


  def InputData.processInput query
    input ||= {}

    # defines permitted commands and converts shortcuts into full commands
    commands = {
      'd' => 'distance',
      'distance' => 'distance',
      'c' => 'count',
      'count' => 'count',
      's' => 'shortest',
      'shortest' => 'shortest'
    }

    # TODO fix regex to strip quotes
    @query = query.split(/,*\ /)

    # check for user input
    if (@query[0]) then
      input["command"] = commands[@query[0].downcase]
    else
      puts "Command missing.  Try again."
      InputData.throw_error
    end

    # all supported commands require at least one argument
    if (@query[1]) then
      input["start"] = @query[1].upcase  #used by all commands but distance

      # if command is distance, make sure route is correctly formatted
      if @command == 'd' || 'distance' then
        input["route"] = input["start"].split(/-/)  #for distance commands
      else
        InputData.throw_error
      end
    else
      puts "first argument error"
      InputData.throw_error
    end

    # optional argument required for Count and Shortest but not for Distance
    if (@query[2]) then
      if input["command"] == 'distance' then
        puts "extra argument for distance command"
        InputData.throw_error
      else
        input["target"] = @query[2].upcase
      end
    elsif input["command"] != 'distance' then
      puts "missing argument for command"
      InputData.throw_error
    end

    if (@query[3]) then
      input["count_type"] = @query[3].downcase
    end

    if (@query[4]) then
      input["threshold"] = @query[4].to_i
    end

    # input["count_type"] && input["threshold"] are optional
    if (input["count_type"] && input["threshold"]) then
      if (input["count_type"] != "max" && input["count_type"] != "exact") then
        puts "Invalid options. Valid entries are 'max', 'exact' or nothing.  You entered #{@query[3]}.\n\n"
        throw :error
      end
    end

    # But if input["count_type"] is passed there must be a input["threshold"] value
    if (input["count_type"] && !input["threshold"]) then
      # if the third parameter (exact||max) is provided, the fourth must be also
      puts "a value is required when passing " + input["count_type"]
      InputData.throw_error
    end

    input
  end
end
