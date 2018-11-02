class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash

    sum = ""
    self.each do |el|
      sum += el.hash.to_s
    end
    sum
  end
end

class String
  def hash
    sum = ""
    self.chars.each do |el|
      sum += el.ord.hash.to_s
    end
    sum.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |k,v|
      sum += k.to_s.hash + v.hash
    end
    sum
  end
end
