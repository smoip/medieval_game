# require 'spec_helper'
# require 'citizen'
# require 'actor_examples'
# require 'owner_examples'

# describe Citizen do
#   it_behaves_like 'actor'
#   it_behaves_like 'owner'

#   subject { described_class.new }

#   describe 'children' do
#     it "is a child if under 14 years old" do
#       allow(subject).to receive(:age).and_return 13
#       expect(subject.child?).to be true
#     end
#     it "is an adult if 14 years old or older" do
#       allow(subject).to receive(:age).and_return 14
#       expect(subject.child?).to be false
#     end

#   end
# end
