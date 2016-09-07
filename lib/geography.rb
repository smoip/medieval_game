module Geography
  # assuming that each pixel is a mile, communication range might be approx the distance a human could walk in an hour
  # this value will be overridden for inhabited sites
  DEFAULT_COMM_RANGE = 3
  TERRAIN_TYPES = [
      "forest",
      "hills",
      "mountain",
      "plains",
      "marsh",
      "desert",
      "ocean",
  ].freeze

  def absolute_distance(point_1, point_2)
    Math.sqrt((point_1.first - point_2.first) ** 2 + (point_1.last - point_2.last) ** 2)
  end

  def terrain_movement_multipliers
    {
      "forest" => 0.5,
      "hills" => 0.8,
      "mountain" => 0.12,
      "plains" => 1,
      "marsh" => 0.25,
      "desert" => 1,
      "ocean" => 0,
    }
  end
end
