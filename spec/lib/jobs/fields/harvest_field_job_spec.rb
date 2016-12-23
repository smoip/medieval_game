# require 'spec_helper'
# require 'jobs/fields/harvest_grain_job'
# require 'job_examples'

# describe HarvestGrainJob do
#   it_behaves_like 'job'

#   let(:field) { instance_double('Field', :reserve => nil, :unreserve => nil, :acreage => 10, :percent_harvested => 0.0, :percent_harvested= => nil)}
#   let(:worker) { instance_double('worker', :busy= => nil, :tired= => nil)}
#   let(:store) { instance_double('Stockpile', :harvested_grain => 0, :harvested_grain= => nil)}

#   subject { described_class.new(field: field, workers: [worker], store: store) }

#   describe '#on_create' do
#     it 'reserves the field' do
#       expect(field).to receive(:reserve)

#       described_class.new(field: field, workers: [worker], store: store)
#     end

#     it 'reserves the workers' do
#       expect(worker).to receive(:busy=)

#       described_class.new(field: field, workers: [worker], store: store)
#     end
#   end

#   describe '#before_work' do
#     it 'checks to make sure that we have at least 5 workers' do
#       allow(subject).to receive_message_chain(:workers, :count).and_return(4)

#       expect(subject.send(:before_work)).to be false
#     end

#     it 'checks to make sure that we have at least 5 workers' do
#       allow(subject).to receive_message_chain(:workers, :count).and_return(5)

#       expect(subject.send(:before_work)).to be true
#     end
#   end

#   describe '#on_work' do
#     it 'exhausts the workers' do
#       expect(worker).to receive(:tired=)

#       subject.send(:on_work)
#     end

#     it 'increases the fields percent_harvested' do
#       allow(field).to receive(:acreage).and_return(10)
#       subject.instance_variable_set(:@workers, [worker] * 5)
#       allow(subject).to receive(:acres_processed_per_worker).and_return(0.4)

#       expect(field).to receive(:percent_harvested=).with(0.2)

#       subject.send(:on_work)
#     end

#     it 'increases the amount of unthreshed grain in the store' do
#       expect(store).to receive(:harvested_grain=).with(1 * 7.0 * 0.4)

#       subject.send(:on_work)
#     end

#     xit 'leaves behind some grain for the church' do

#       subject.send(:on_work)
#     end
#   end

#   describe '#on_rescue' do
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
