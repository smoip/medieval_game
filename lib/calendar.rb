require 'yaml'
require 'active_support/core_ext/numeric/time'

class Calendar
  TICK_LENGTH = 1.hour

  class << self
    def date
      @date ||= Date.new(800, 1, 1, Date::GREGORIAN)
    end
    def date=(date)
      @date = date
    end
    def tick
      Calendar.date += Calendar::TICK_LENGTH

      return nil
    end

    def months_activities
      {
        "festivals"   => festivals[month_name],
        "work_groups" => work_groups[month_name]
      }
    end

    private

    def month_name
      date.strftime("%B").downcase
    end

    def season
      case date.month
      when 1..3
        'winter'
      when 4..6
        'spring'
      when 7..9
        'summer'
      when 10..12
        'fall'
      end
    end

    def festivals
      @festivals ||= yaml_load("festivals")["default"]
    end

    def work_groups
      @work_groups ||= yaml_load("work_groups")["default"]
    end

    def yaml_load(file)
      File.open("config/#{file}.yml") { |file| YAML.load(file) }
    end
  end
end
