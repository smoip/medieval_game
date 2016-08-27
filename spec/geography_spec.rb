require 'geography'

RSpec.describe Geography do
  let(:module_test) { Class.new { include Geography } }

  describe ".absolute_distance" do
    let(:point_1) { [2, 4] }
    let(:point_2) { [10, 10] }

    it "calculates the hypotenuese between two points" do
      expect(module_test.new.absolute_distance(point_1, point_2)).to eq(10)
    end
  end
end
