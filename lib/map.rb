require 'geography'
require 'chunky_png'

class Map
  include Geography

  attr_accessor :grid

  def initialize
    @grid = generate_grid
  end

  def height_map
    @height_map ||= open_map
  end

  def open_map
    # TODO: mechanism to choose height_map
    ChunkyPNG::Image.from_file(Dir["lib/data/maps/*"].first)
  end

  def generate_grid
    (0...height_map.dimension.height).map do |x|
      (0...height_map.dimension.width).map do |y|
        {
          terrain_type: terrain_type(x, y),
        }
      end
    end
  end

  def terrain_type(x, y)
    return "ocean" if elevation_at_point(x, y) <= 0

    # TODO: decide how terrain types are assigned 
    TERRAIN_TYPES[rand(TERRAIN_TYPES.count - 1)]
  end

  def elevation_at_point(x, y)
    ChunkyPNG::Color.grayscale_teint(height_map[x, y])
  end
end
