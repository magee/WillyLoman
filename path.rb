# TODO: refactor to use Path classes and Node classes
class Path

  attr_reader :start, :target, :distance

  def add start, target, distance
    @start       = start
    @target    = target
    @distance    = distance
  end

end