require 'celluloid/current'

require 'citizen'
require 'site'
require 'work_group'
require 'field'
require 'stockpile'

class Village < Site
  include Celluloid

  attr_accessor :shire
  attr_accessor :comm_range
  attr_accessor :work_groups, :families
  attr_reader :citizens

  def initialize(map: nil, coordinates: nil)
    super(map: map, coordinates: coordinates)

    # TODO: make a lord object that owns things
    @lord           = Citizen.new
    # TODO: make a church object that owns things
    @priest         = Citizen.new
    @families       = []
    # TODO: take the Reeve's work out of the collective labor pool
    @reeve          = Citizen.new

    @stockpile    = Stockpile.new
    @fields       = [Field.new(acres: 10)]

    @shire          = Object.new

    # @yearly_labor_levy = 40 # days of service to the lord in exchange for protection
    # @yearly_tax_to_lord = :unknown # percent of goods/wealth sent to lord
    # @yearly_tithe_to_church = :unknown # percent of goods/wealth sent to church

    @work_groups = []

    @comm_modifier = 0
  end

  def tick
    if Calendar.date.mday == 1 && Calendar.date.hour == 1
      # FIXME: This may be deleting tasks that still need to be done
      # TODO: Implement max amount of time to try a thing. Like, we
      # could only plant so much this year, so that sucks.
      reset_work_groups
    end

    if Calendar.date.hour > 5 && Calendar.date.hour < 22
      generate_work_groups(fields: fields) if work_groups.empty?
      assign_citizens_to_work_groups
      get_shit_done
    else
      quitting_time
    end

    return nil
  end

  def citizens
    citizens = families.map do |family|
      [family.adults, family.children]
    end
    citizens.flatten.compact
  end

  def fields
    families.map(&:fields).flatten # | families.fields | lord.fields | church.fields
  end

  # def professionals
  #   {
  #     :bakers => [Citizen.new],
  #     :blacksmiths => [Citizen.new],
  #     :potter => [Citizen.new],
  #     :priest => [Citizen.new],
  #     :carpenters => [Citizen.new, Citizen.new], # "a couple"
  #     :masons => [Citizen.new, Citizen.new] # "a couple"
  #   }
  # end

  # def structures
  #   {
  #     :mill => Object.new(cost: "unknown", owner: Object.new, benefit: "100%"),
  #     :wine_press => Object.new(cost: "unknown", owner: Object.new, benefit: "115%"),
  #     :olive_press => Object.new
  #   }
  # end

  def advertise_work_group(name:, max_adults:, max_children:, person_days:)
    self.work_groups << WorkGroup.new(
      name: name,
      max_adults: max_adults,
      max_children: max_children,
      person_days: person_days
    )
  end

  private

  def comm_range
    super + comm_modifier
  end

  def reset_work_groups
    # info "NOT FINISHED! #{self.work_groups.reject(&:finished?)}"
    self.work_groups = []
  end

  def generate_work_groups(fields:)
    Calendar.months_activities["work_groups"].map do |name, needs|
      type = needs.keys.first
      values = needs.values.first

      case type
      when "fixed_per_day"
        advertise_work_group(
          name: name,
          max_adults: values["max_adults"],
          max_children: values["max_children"],
          person_days: values["person_days"]
        )
      when "per_acre_per_day"
        fields.map do |field|
          advertise_work_group(
            name: "#{name} #{field.object_id}",
            max_adults: ((values["max_adults"] || 0) * field.acreage).ceil,
            max_children: ((values["max_children"] || 0) * field.acreage).ceil,
            person_days: ((values["max_adults"] || 0) + (values["max_children"] || 0)) * field.acreage
          )
        end
      end
    end

    return nil
  end

  def assign_citizens_to_work_groups
    available_work_groups = work_groups.reject(&:finished?).reject(&:full?)

    citizens.reject(&:busy?).each do |citizen|
      wg = available_work_groups.sample

      unless wg.nil?
        wg.sign_up(child: citizen.child?)
        citizen.sign_up
      end
    end

    return nil
  end

  def get_shit_done
    work_groups.reject(&:finished?).each do |work_group|
      work_group.progress
    end

    return nil
  end

  def quitting_time
    work_groups.each do |work_group|
      work_group.empty
    end
    citizens.select(&:busy?).each do |citizen|
      citizen.leave
    end

    return nil
  end
end
