# require 'spec_helper'
# require 'family'
# require 'actor_collection_examples'
# require 'owner_examples'

# describe Family do
#   it_behaves_like 'actor_collection'
#   it_behaves_like 'owner'

#   subject {
#     described_class.new(
#       head: instance_double("Citizen", :work => true),
#       next_in_line: instance_double("Citizen", :work => true),
#       members: [instance_double("Citizen", :child? => true, :work => true)]
#     )
#   }

#   it 'does something' do
#     subject
#   end
# end
