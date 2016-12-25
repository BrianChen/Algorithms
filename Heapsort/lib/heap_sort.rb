require_relative "heap"

class Array
  def heap_sort!
    (2..self.length).to_a.each do |heap_sz|
      BinaryMinHeap.heapify_up(self, heap_sz - 1, heap_sz)
    end

    (2..self.length).to_a.reverse.each do |heap_sz|
      tmp = self[heap_sz - 1]
      self[heap_sz - 1] = self[0]
      self[0] = tmp
      BinaryMinHeap.heapify_down(self, 0, heap_sz - 1)
    end

    self.reverse!
  end
end
