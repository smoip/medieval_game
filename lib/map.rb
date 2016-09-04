require 'geography'

class Map
  include Geography

  attr_accessor :grid

  def initialize(dimensions)
    @grid = generate_grid(dimensions)

    # TODO: get dimensions, elevation from height map file 
    @height_map = nil
  end

  def generate_grid(dimensions)
    dimensions.times.map do |x|
      dimensions.times.map do |y|
        { 
          terrain_type: terrain_type([x, y]),
        }
      end
    end
  end

  def terrain_type(coordinates)
    return "ocean" if elevation(coordinates) <= 0

    # TODO: decide how terrain types are assigned 
    TERRAIN_TYPES[rand(TERRAIN_TYPES.count - 1)]
  end

  def elevation(coordinates)
    # TODO: check heightmap for elevation 
    531
  end
end
