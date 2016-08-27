require 'spec_helper'
require 'site'

describe Site do
  let(:site) { Site.new(map, coordinates)}
  let(:map) { double(sites: sites) }
  let(:coordinates) { [4, 4] }
  let(:sites) { [] }
  
  context "with other sites on map" do
    let(:sites) { [neighbor, distant_site] }
    let(:neighbor) { Site.new(:map_id, [5, 4]) }
    let(:distant_site) { Site.new(:map_id, [8, 8]) }

    it "finds neighbors" do
      expect(site.neighbors).to include(neighbor) 
      expect(site.neighbors).not_to include(distant_site) 
    end
  end

end
