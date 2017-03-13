class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length == 0

    new_pivot = rand(array.length)
    tmp = array[0]
    array[0] = array[new_pivot]
    array[new_pivot] = tmp
    pivot = array[0]

    middle = array.index(pivot)
    left = []
    right = []
    array.each do |num|
      if pivot > num
        left.push(num)
      elsif pivot < num
        right.push(num)
      end
    end
    sort1(left) + middle + sort1(right)
  end

  # In-place. Uses O(log(n)) space for recursion.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx + 1, right_length, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx = start
    pivot = array[start]
    ((start + 1)...(start + length)).each do |idx|
      val = array[idx]
      if !(prc.call(pivot, val) < 1)
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = val
        pivot_idx += 1
      end
    end

    pivot_idx
  end
end
