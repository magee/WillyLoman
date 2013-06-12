require './graph'
require './inputdata'

class App

  @@graph ||= Graph.new

  def run_app

    # get user input, process it and assign populate apprioriate data structure
    userInput = InputData.getUserInput

    case userInput["command"]
      when 'distance'
        distance = @@graph.distance userInput["route"]
        puts "total distance: #{distance}"
      when 'count'
        count = @@graph.count_of_stops userInput["start"], userInput["terminus"], userInput["count_type"] || nil, userInput["threshold"] || nil
        puts "total number of stops: #{count}"
      when 'shortest'
        shortest = @@graph.shortest_route userInput["start"], userInput["terminus"]
        puts "shortest route: #{shortest}"
      else
        puts "command processing error - app.rb"
        # throw error
    end

    puts "\n\nThank you for using the Railroad Grapher!"
  end
end


app = App.new
catch(:error) do
  app.run_app
end



