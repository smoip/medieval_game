# require 'spec_helper'
# require 'jobs/fields/plant_grain_job'
# require 'job_examples'

# describe PlantGrainJob do
#   it_behaves_like 'job'

#   let(:field) { instance_double('Field', :reserve => nil, :unreserve => nil, :percent_sown => 15, :percent_sown= => nil, :sown? => false, :acreage => 10)}
#   let(:worker) { instance_double('worker', :busy= => nil, :tired= => nil)}
#   let(:store) { instance_double('Stockpile', :reserve_seed_stock => nil, :remove_seed_stock => nil, :unreserve_seed_stock => nil)}

#   subject { described_class.new(field: field, workers: [worker], store: store) }

#   before(:each) do
#     allow(subject).to receive(:percent_seed_stock).and_return(1)
#     allow(subject).to receive(:percent_workers).and_return(1)
#   end

#   describe '#on_create' do
#     it 'reserves the field' do
#       expect(field).to receive(:reserve)

#       described_class.new(field: field, workers: [worker], store: store)
#     end

#     it 'reserves the workers' do
#       expect(worker).to receive(:busy=)

#       described_class.new(field: field, workers: [worker], store: store)
#     end

#     it 'reserves the seed stock' do
#       expect(store).to receive(:reserve_seed_stock)

#       described_class.new(field: field, workers: [worker], store: store)
#     end
#   end

#   describe '#before_work' do
#   end

#   describe '#on_work' do
#     before(:each) do
#       allow(subject).to receive(:acres_processed_per_person).and_return(2.0)
#       allow(subject).to receive(:percent_seed_stock).and_return(1.0)
#       allow(subject).to receive(:percent_workers).and_return(1.0)
#       allow(field).to receive(:percent_sown).and_return(0)
#       allow(field).to receive(:acreage).and_return(10)
#     end

#     it 'removes the seed stock' do
#       expect(store).to receive(:remove_seed_stock)

#       subject.send(:on_work)
#     end

#     it 'exhausts the workers' do
#       expect(worker).to receive(:tired=)

#       subject.send(:on_work)
#     end

#     it 'increases the percent_sown' do
#       expect(field).to receive(:percent_sown=)

#       subject.send(:on_work)
#     end

#     it 'increases the percent_sown relative to the amount of seed' do
#       allow(subject).to receive(:percent_seed_stock).and_return(0.8)

#       expect(field).to receive(:percent_sown=).with(2.0 * 1.0 * 0.8 / 10)

#       subject.send(:on_work)
#     end

#     it 'increases the percent_sown relative to the amount of workers' do
#       allow(subject).to receive(:percent_workers).and_return(0.8)

#       expect(field).to receive(:percent_sown=).with(2.0 * 1.0 * 0.8 / 10)

#       subject.send(:on_work)
#     end

#     it 'asks to increases percent_sown past 100 without a care' do
#       allow(field).to receive(:percent_sown).and_return(100)

#       # 100.2 = 100 + (2.0 * 1.0 * 1.0 / 10)
#       expect(field).to receive(:percent_sown=).with(100.2)

#       subject.send(:on_work)
#     end
#   end

#   describe '#on_rescue' do
#     it 'unreserves stock on exception' do
#       allow(subject).to receive(:on_work).and_raise('fake error')

#       expect(store).to receive(:unreserve_seed_stock)

#       expect { subject.work }.to raise_error('fake error')
#     end
#   end

#   describe '#on_finalize' do
#     it 'releases the workers' do
#       expect(worker).to receive(:busy=).with(false)

#       subject.send(:on_finalize)
#     end

#     it 'releases the field' do
#       expect(field).to receive(:unreserve)

#       subject.send(:on_finalize)
#     end
#   end
# end
