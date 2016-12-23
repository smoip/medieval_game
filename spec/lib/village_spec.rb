require 'spec_helper'
require 'calendar'
require 'village'
require 'actor_collection_examples'

describe Village do
  it_behaves_like 'actor_collection'

  after :each do
    Calendar.date = DateTime.new(800, 1, 1, 0, 0, 0, 0, Date::GREGORIAN)
  end

  # describe '#reset_work_orders' do
  #   before :each do
  #     allow(subject.wrapped_object).to receive(:advertise)
  #   end

  #   it 'resets on the first of the month' do
  #     Calendar.date = DateTime.new(800, 1, 1, 1, 0, 0, 0, Date::GREGORIAN)

  #     subject.work_orders = [instance_double("WorkOrder", :finished? => true)]
  #     subject.send(:reset_work_orders)
  #     expect(subject.work_orders).to eq([])
  #   end
  # end

  describe '#tick' do
    # it 'resets in the first hour of the month' do
    #   Calendar.date = DateTime.new(800, 1, 1, 1, 0, 0, 0, Date::GREGORIAN)

    #   expect(subject.wrapped_object).to receive(:reset_work_orders)
    #   subject.tick
    # end

    it 'orchestrates work during working hours' do
      Calendar.date = DateTime.new(800, 1, 1, 6, 0, 0, 0, Date::GREGORIAN)

      # expect(subject.wrapped_object).to receive(:advertise)
      # expect(subject.wrapped_object).to receive(:assign_citizens_to_work_orders)
      expect(subject.wrapped_object).to receive(:work)
      subject.tick
    end

    # it 'sends citizens to bed outside of working hours' do
    #   Calendar.date = DateTime.new(800, 1, 1, 23, 0, 0, 0, Date::GREGORIAN)

    #   expect(subject.wrapped_object).to receive(:quitting_time)
    #   subject.tick
    # end
  end
end
