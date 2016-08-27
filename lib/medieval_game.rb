$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'calendar'
require 'citizen'
require 'village'

class MedievalGame
  attr_accessor :villages

  def initialize
    @villages = []
  end

  def tick
    Calendar.increment_date!
    villages.map { |village| village.tick }
  end
end

if $PROGRAM_NAME == __FILE__
  require 'benchmark'
  game = nil

  number_of_villages = 1
  # number_of_villages = 9000
  number_of_villagers = 10
  # number_of_villagers = 500
  number_of_ticks = 52.weeks / MedievalGame::TICK_LENGTH

  Benchmark.bm(13) do |results|
    results.report("init:") do
      game = MedievalGame.new
    end
    results.report("init villages:") do
      number_of_villages.times do
        game.villages << Village.new(game: game)
      end
    end
    game.villages.each do |village|
      results.report("init citizens:") do
        number_of_villagers.times do
          village.citizens << Citizen.new(village: village)
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
