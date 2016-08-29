$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'celluloid/current'

require 'calendar'
require 'citizen'
require 'village'

class MedievalGame
  include Celluloid
  include Celluloid::Notifications
  include Celluloid::Internals::Logger

  attr_accessor :villages

  def initialize
    @villages = []
  end

  def tick
    Calendar.tick

    # info "\nTICK\n #{Calendar.date}"

    villages.each do |village|
      village.async.tick
    end

    return nil
  end
end

if $PROGRAM_NAME == __FILE__
  require 'benchmark'
  game = nil

  number_of_villages = 10
  # number_of_villages = 9000
  number_of_villagers = 200
  # number_of_villagers = 500
  # number_of_ticks = 6
  number_of_ticks = 52.weeks / Calendar::TICK_LENGTH


  Benchmark.bm(13) do |results|
    results.report("init:") do
      game = MedievalGame.new
    end
    results.report("init villages:") do
      number_of_villages.times do
        game.villages << Village.new(map: "", coordinates: "")
      end
    end
    game.villages.each do |village|
      results.report("init citizens:") do
        number_of_villagers.times do
          village.citizens << Citizen.new
          village.citizens << Citizen.new(child: true)
        end
      end
    end
    results.report("one year:") do
      number_of_ticks.times do
        game.tick
      end
    end
  end
end
