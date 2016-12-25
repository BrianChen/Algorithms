require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    return true if @store[num] == true
    false
  end

  private

  def is_valid?(num)
    if num >= 0 && num < @store.length
      return true
    end
    false
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num) unless include?(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num) if include?(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

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
    return false if include?(num)
    @store[num % num_buckets].push(num)
    @count += 1
    resize! if num_buckets < @count
    num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    new_size = num_buckets * 2
    @store = Array.new(new_size) { Array.new }
    @count = 0

    old_store.each { |bucket| bucket.each { |num| insert(num)}}
  end
end
