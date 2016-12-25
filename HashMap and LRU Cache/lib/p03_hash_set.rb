require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    @store[key.hash % num_buckets].push(key)
    @count += 1
    resize! if num_buckets < @count
    key
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].delete(key)
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
