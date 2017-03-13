def insertion_sort(arr)
  return arr if arr.length <= 1

  result = [arr[0]]

  (1..arr.length-1).each do |idx|
    idx2 = result.length-1
    while idx2 >= 0
      if arr[idx] > result[idx2]
        left = result[0..idx2]
        left.push(arr[idx])
        right = result[idx2+1..-1]
        result = left + right
      end
      idx2 -= 1
    end
  end

  result
end

arr = [6,5,3,1,8,7,2,4];
p insertion_sort(arr);
