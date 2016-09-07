require 'spec_helper'
require 'map'

describe Map do
  describe '#new' do
    describe 'grid' do
      let(:dimensions) { 10 }
      let(:map) { Map.new(dimensions) }

      it 'generates a grid of <dimensions> size' do
        expect(map.grid.count).to eq(10)
        expect(map.grid[0].count).to eq(10)
      end

      it 'stores terrain info at x, y coordinates' do
        expect(map.grid[2][2]).to have_key(:terrain_type)
      end

      it 'assigns ocean spaces'
    end
  end
end
