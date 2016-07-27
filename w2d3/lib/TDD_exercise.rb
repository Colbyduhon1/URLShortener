
#   def my_uniq
#     out = []
#     self.each do |n|
#       out.push(n) unless out.include?(n)
#     end
#     out
#   end

class Array


  # def two_sum
  #   indeces = []
  #   perms = self.combination(2).to_a
  #   perms.each do |pair|
  #     if pair.inject(:+) == 0
  #       pair.each do |el|
  #         indeces << self.index(el)
  #       end
  #     end
  #   end
  #   indeces.each_slice(2).to_a
  # end


  # def my_transpose
  #   out = []
  #   self.each_with_index do |row,i|
  #     out<< row[i]
  #   end
  #   out
  # end
  # def stock_picker
  #   ideal_diff = [[0,0]]
  #   self.each_with_index do |price, i|
  #     j = i+1
  #     while i+j < self.length
  #       if  [price, self[i+j]].reverse.inject(:-) > ideal_diff.last.reverse.inject(:-)
  #         ideal_diff << [price, self[i+j]]
  #       end
  #       j += 1
  #     end
  #   end
  #   ideal_diff.last
  # end
end

class Towers

  attr_accessor :tower_disk_arrays

  def initialize
    @tower_disk_arrays = [[],[],[]]
    # tower1...
  end

  def set_towers(disk_array)
    @tower_disk_arrays = disk_array
  end

  def move(start_tower, end_tower)
    if @tower_disk_arrays[end_tower].last > @tower_disk_arrays[start_tower].last
      move_disk = @tower_disk_arrays[start_tower].pop
      @tower_disk_arrays[end_tower].push(move_disk)
      return true
    end
    false
  end

  def won?
     p @tower_disk_arrays.last.length
    return true if @tower_disk_arrays.last.length == 8
    false
  end

end
