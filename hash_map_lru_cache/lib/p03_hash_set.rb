class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count +=1
    if @count % num_buckets == 1
      resize!
    end
    # byebug
    if self.include?(key)
      self.remove(key)
    end
    self[key]<< key unless self.include?(key)
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(@store.length) { Array.new }
    (@store.length / 2).times do |bucket|
      @store[bucket].each do |el|
        @store[bucket].delete(el)
        insert(el)
      end
    end
  end
end
