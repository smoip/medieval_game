require 'spec_helper'
require 'citizen'

describe Citizen do
  let(:work_groups) { [instance_double("WorkGroup", :sign_up => true)] }
  let(:village) { instance_double("Village", :work_groups => work_groups) }
  subject { described_class.new(village: village) }

  describe 'initialization' do
    it 'sets the values' do
      stub_const("Citizen::VALUES", {:test => 35})
      expect(subject.values[:test]).to eq(35)
    end
  end

  describe 'within a village' do
    subject { described_class.new(village: village) }

    describe 'finding work to do' do
      it 'asks about work available' do
        expect(village).to receive(:work_groups)
        expect(subject).to receive(:do_the_thing)
        subject.tick
      end
    end
  end
end
