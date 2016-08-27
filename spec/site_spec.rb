require 'spec_helper'
require 'site'

describe Site do
  let(:site) { Site.new(map, coordinates)}
  let(:map) { double(sites: sites) }
  let(:coordinates) { [4, 4] }
  let(:sites) { [] }
  
  context "with other sites on map" do
    let(:sites) { [neighbor, distant_site, same_site] }
    let(:neighbor) { Site.new(:map, [5, 4]) }
    let(:distant_site) { Site.new(:map, [8, 8]) }
    let(:same_site) { Site.new(:map, [4, 4]) }
    # should eventually have validations on sites ensuring unique coordinates

    it "finds neighbors within comm range" do
      expect(site.neighbors).to include(neighbor) 
      expect(site.neighbors).not_to include(distant_site) 
      expect(site.neighbors).not_to include(same_site) 
    end
  end
end
