require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    if @store[num] == true
      return true
    else
      return false
    end
  end

  private

  def is_valid?(num)
    if num > @store.length || num < 0
      raise "Out of bounds"
    else
      return true
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # byebug
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count +=1
    if @count % num_buckets == 1
      self.resize!
    end
    # byebug
    if self.include?(num)
      self.remove(num)
    end
    self[num]<< num unless self.include?(num)
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  # private

  def [](num)
    @store[num % num_buckets]
  end
  # def []=(num, val)
  #   @store[num % num_buckets] << val
  # end

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
    # @count = 0
  end

end
