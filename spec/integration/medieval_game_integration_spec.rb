require 'integration_spec_helper'
require 'medieval_game'

describe MedievalGame do
  after :each do
    Calendar.date = DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
  end

  it 'runs one tick without exploding' do
    number_of_villages = 1
    number_of_families = 50
    number_of_ticks = 52.weeks / Calendar::TICK_LENGTH

    game = MedievalGame.new
    number_of_villages.times do
      game.villages << Village.new(map: "", coordinates: "")
    end
    game.villages.each do |village|
      # (number_of_families).times do
      #   family = Family.new(
      #     head: Citizen.new,
      #     next_in_line: Citizen.new,
      #     members: [
      #       Citizen.new(age: 14),
      #       Citizen.new(age: 14),
      #       Citizen.new(age: 14),
      #       Citizen.new(age: 14)]
      #   )
      #   family.fields = [
      #     Field.new(acres: 7),
      #     Field.new(acres: 7),
      #     Field.new(acres: 7),
      #   ]
      #   village.families << family
      # end
    end
    number_of_ticks.times do
      expect { game.tick }.to_not raise_error
    end
  end
end
