# require "Enumerable"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to
    # # next link and removes self from list.
    # self.next.prev = self.prev
    # self.prev.next = self.next
    # self.next = nil
    # self.prev = nil
    # @val = nil
  end

end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    thing = Node.new(key, val)
    thing.next = @tail
    thing.prev = @tail.prev
    temp = @tail.prev
    @tail.prev = thing
    temp.next = thing
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.next.prev = node.prev
        node.prev.next = node.next
        node.next = nil
        node.prev = nil
        # node.remove
        break
      end
    end
  end

  def each
    start = @head.next
    until start == @tail
      yield(start)
      start = start.next
    end
  end

end
