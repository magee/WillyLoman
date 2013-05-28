class Path

  attr_reader :start, :terminus, :distance

  def add start, terminus, distance
    @start       = start
    @terminus    = terminus
    @distance    = distance
  end

end