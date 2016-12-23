$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'calendar'
# require 'citizen'
require 'village'
# require 'family'

class MedievalGame
  include Celluloid::Internals::Logger

  attr_accessor :villages

  def initialize
    @villages = []
  end

  def tick
    Calendar.tick

    info "TICK: #{Calendar.date}"

    villages.each do |village|
      village.tick
    end

    return nil
  end
end

if $PROGRAM_NAME == __FILE__
  require 'benchmark'
  game = nil

  number_of_villages = 10
  # number_of_villages = 9000
  number_of_families = 50
  # number_of_families = 200
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
      # results.report("init citizens:") do
      #   (number_of_families).times do
      #     family = Family.new(
      #       head: Citizen.new,
      #       next_in_line: Citizen.new,
      #       members: [
      #         Citizen.new(age: 14),
      #         Citizen.new(age: 14),
      #         Citizen.new(age: 14),
      #         Citizen.new(age: 14)]
      #     )
      #     family.fields = [
      #       Field.new(acres: 7),
      #       Field.new(acres: 7),
      #       Field.new(acres: 7),
      #     ]
      #     village.families << family
      #   end
      # end
    end
    1.upto(52) do |i|
      results.report("week #{i}:") do
        (1.week / Calendar::TICK_LENGTH).times do
          game.tick
        end
      end
    end
  end
end
