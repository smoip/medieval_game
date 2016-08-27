require 'geography'

class Site
  include Geography

  attr_accessor :population, :defense_rating, :offense_rating
  attr_accessor :structures
  attr_accessor :neighbors, :coordinates

  def initialize(map, coordinates)
    @population     = 0
    @defense_rating = 0
    @offense_rating = 0

    @structures     = []

    @map            = map
    @coordinates    = coordinates
  end

  def neighbors
    @neighbors ||= find_neighbors
  end

  private

  def find_neighbors
    @map.sites.select { |s| (absolute_distance(coordinates, s.coordinates) <= comm_range) && s.coordinates != @coordinates }
  end

  def comm_range
    @comm_range = DEFAULT_COMM_RANGE
  end
end
