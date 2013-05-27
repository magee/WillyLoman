class Path

  @start_town
  @connected_town
  @distance

  def initialize path_start, path_end, distance
    @start_town = path_start
    @connected_town = path_end
    @distance = distance
    self
  end
end
