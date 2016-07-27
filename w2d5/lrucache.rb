class LRUCache

  def initialize(size)
    @size = size
    @the_cache = []
  end

  def add(input)
    if @the_cache.length < size
      @the_cache << {input => 1}
    else
      @the_cache.each do |item|
        #if it exists already
        if item.keys[0] == input
          @the_cache[item] += 1
          return
        end
      end

    end
  end

  def count
    @the_cache.length
  end

  def show
    @the_cache.map do |item|
      item.keys[0]
    end
  end
end


  johnny_cache.add([1,2,3]) #[[1,2,3]]
  johnny_cache.add(5) #[[1,2,3], 5]
  johnny_cache.add(-5)#[[1,2,3], 5, -5]
  johnny_cache.add({a: 1, b: 2, c: 3}) #[[1,2,3], 5, -5, {a: 1, b: 2, c: 3}]
  johnny_cache.add([1,2,3,4]) #[[1,2,3,4], 5, -5, {a: 1, b: 2, c: 3}]
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})
