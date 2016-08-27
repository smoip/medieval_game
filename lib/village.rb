require 'site'

class Village < Site
  attr_accessor :citizens, :council
  attr_accessor :stockpile, :fields
  attr_accessor :shire
  attr_accessor :comm_range

  def initialize(map, coordinates)
    super
    @citizens       = []
    @council        = []

    @stockpile      = []
    @fields         = []
    @jobs           = {}

    @shire          = Object.new
    
    @comm_modifier = 0
  end

  def tick
    citizens.map { |c| c.tick }
  end

  private

  def avg(attribute)
    @citizens.map(&attribute).reduce(:+) / @citizens.count
  end

  def comm_range
    super + comm_modifier
  end
end
