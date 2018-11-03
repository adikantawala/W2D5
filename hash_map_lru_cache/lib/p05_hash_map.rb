require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].each do |node|
      return true if node.key == key
    end
    false
  end

  def set(key, val)

    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
      # if @count % num_buckets == 1
      #   resize!
      # end
    end
  end

  def get(key)

    if @store[bucket(key)].include?(key)
      return @store[bucket(key)].get(key)
    end
  end

  # def [](key)
  #   if @store[bucket(key)].include?(key)
  #     return @store[bucket(key)].get(key)
  #   end
  # end

  def delete(key)
    @count -= 1
    if @store[bucket(key)].remove(key)
      return key
    end
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  # def resize!
  #   @store += Array.new(@count-1) { LinkedList.new }
  #   (@store.length / 2).times do ||
  #     @store[bucket].each do |el|
  #       @store[bucket].delete(el)
  #       insert(el)
  #     end
  #   end
  # end

  def bucket(key)
    key.hash % num_buckets
  end
end
