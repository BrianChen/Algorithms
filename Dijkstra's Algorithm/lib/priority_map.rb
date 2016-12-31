require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    prc ||= Proc.new { |x,y| x <=> y }
    @prc = prc
    self.map = {}
    self.queue = BinaryMinHeap.new do |key1, key2|
      prc.call(self.map[key1], self.map[key2])
    end
  end

  def [](key)
    self.map[key]
  end

  def []=(key, value)
    if self.map.include?(key)
      update(key, value)
    else
      insert(key, value)
    end
  end

  def count
    self.map.count
  end

  def empty?
    self.map.empty?
  end

  def extract
    key = self.queue.extract
    value = self.map.delete(key)
    [key, value]
  end

  def has_key?(key)
    self.map.has_key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    unless self.map.include?(key)
      self.map[key] = value
      self.queue.push(key)
    end
  end

  def update(key, value)
    throw "tried to update non-existent key" unless self.map.has_key?(key)
    self.map[key] = value
    self.queue.reduce!(key)
    nil
  end
end
