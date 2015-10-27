class Map
  attr_reader :compass

  def initialize(width, length)
    @width = width
    @length = length
    @compass = [:north, :east, :south, :west]
  end

  def tile_available?(x, y, vector)
    place_available?(x + vector.first, y + vector.last)
  end

  def place_available?(x, y)
    (0 <= x && x <= @width) && (0 <= y && y <= @length)
  end
end