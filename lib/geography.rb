module Geography
  DEFAULT_COMM_RANGE = 3
  # assuming that each pixel is a mile, communication range might be approx the distance a human could walk in a mile
  # this value will be overridden for inhabited sites

  def absolute_distance(point_1, point_2)
    Math.sqrt((point_1.first - point_2.first) ** 2 + (point_1.last - point_2.last) ** 2)
  end
end
