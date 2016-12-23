# require 'spec_helper'
# require 'work_order'

# describe WorkOrder do
#   subject {
#     described_class.new(
#       work_object: Object.new,
#       name: "test",
#       max_adults: 2,
#       max_children: 2,
#       person_days: 40
#     )
#   }

#   describe 'full work group' do
#     before :each do
#       subject.sign_up
#       subject.sign_up
#       subject.sign_up(child: true)
#       subject.sign_up(child: true)
#     end

#     it 'reports that it is full' do
#       expect(subject.full?).to be true
#     end

#     it 'progress' do
#       expect(subject.completeness).to eq(0)
#       subject.progress
#       expect(subject.completeness).to eq(10)
#     end

#     it 'finishes' do
#       expect(subject.completeness).to eq(0)
#       10.times { subject.progress }
#       expect(subject.completeness).to eq(100)
#     end
#   end

#   describe 'half-full progress group' do
#     before :each do
#       subject.sign_up
#       subject.sign_up(child: true)
#     end

#     it 'reports that it is not full' do
#       expect(subject.full?).to be false
#     end

#     it 'progress' do
#       expect(subject.completeness).to eq(0)
#       subject.progress
#       expect(subject.completeness).to eq(5)
#     end
#   end
# end
