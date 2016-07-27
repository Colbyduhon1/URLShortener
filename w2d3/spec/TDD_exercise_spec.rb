require 'TDD_exercise'

describe Array do
#   let(:my_array) {[2,2,3]}
#   let(:array2) {[1,2,1,3,3]}
#   it "removes duplicate values" do
#     expect(my_array.my_uniq).to eq([2,3])
#   end
#
#   it "preserves the order of the original array" do
#     expect(array2.my_uniq).to eq([1,2,3])
#   end
#
  # let(:array1) {[-1, 0, 2, -2, 1]}
  #
  # it "correctly identifies pairs that sum to zero" do
  #   expect(array1.two_sum.include?([0,4])).to be true
  # end
  # it "puts the indeces of the smaller elements out first" do
  #   expect(array1.two_sum).to eq([[0,4],[2,3]])
  # end

  # let(:array1) {[
  #   [0, 1, 2],
  #   [3, 4, 5],
  #   [6, 7, 8]
  # ]}
  #
  # let(:transposed) {cols = [
  #   [0, 3, 6],
  #   [1, 4, 7],
  #   [2, 5, 8]
  # ]}
  #
  # it "switches cols and rows" do
  #   expect(array1.transpose).to eq(transposed)
  # end
  #
  # let(:prices) {[17,3,6,9,15,8,6,1,10] }
  #
  # it "returns the most profitable stock price pair" do
  #   expect(prices.stock_picker).to eq([3,15])
  # end




end


describe Towers do

  subject(:tower) {Towers.new}


    describe "#won?" do
      it "ends the game when the right tower has all the rings" do
        tower.tower_disk_arrays = [[],[],[8,7,6,5,4,3,2,1]]
        expect(tower.won?).to be true
      end

      it "indicates if the game is not won" do
        tower.tower_disk_arrays = [[5,3,1], [9,8,7], [6,4,2]]
        expect(tower.won?).to be false
      end

    end

    describe "#move" do
      it "returns returns false for an invalid move" do
        tower.tower_disk_arrays = [[8,7,6],[5,4,3],[2,1]]
        expect(tower.move(1,2)).to be false
      end

      # it "places a disk on top of a disk of greater size" do
      #   tower.tower_disk_arrays = [[8,7,3],[6,5,4],[2,1]]
      #     expect(tower.move(1,2)).to be true
      # end
    end

end
