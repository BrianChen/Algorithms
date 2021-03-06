require 'byebug'
class BinaryMinHeap
  def initialize(&prc)
    self.store = []
  end

  def count
    @store.length
  end

  def extract
    raise "no element to extract" if count == 0

    val = store[0]

    if count > 1
      store[0] = store.pop
      self.class.heapify_down(store, 0)
    else
      store.pop
    end

    val
  end

  def peek
    raise "no element to peek" if count == 0
    store[0]
  end

  def push(val)
    store << val
    self.class.heapify_up(store, self.count - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [2*parent_index + 1, 2*parent_index + 2].select { |idx| len > idx }
  end

  def self.parent_index(child_index)
    parent_index = (child_index-1)/2
    if parent_index < 0
      raise "root has no parent"
    else
      parent_index
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    l_child_idx, r_child_idx = child_indices(len, parent_idx)
    parent_val = array[parent_idx]
    children = []
    children << array[l_child_idx] if l_child_idx
    children << array[r_child_idx] if r_child_idx
    if children.all? { |child| prc.call(parent_val, child) <= 0 }
      return array
    end
    swap_idx = nil
    if children.length == 1
      swap_idx = l_child_idx
    else
      swap_idx =
        prc.call(children[0], children[1]) == -1 ? l_child_idx : r_child_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) >= 0
      return array
    else
      tmp = array[parent_idx]
      array[parent_idx] = array[child_idx]
      array[child_idx] = tmp
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
