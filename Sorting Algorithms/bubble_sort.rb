def bubble_sort(arr)
  return arr if arr.length <= 1

  num = arr.length - 1
  while num > 0
    (0..num-1).each do |i|
      if arr[i] > arr[i+1]
        tmp = arr[i]
        arr[i] = arr[i+1]
        arr[i+1] = tmp
      end
    end
    num -= 1
  end
  arr
end

arr = [6,5,3,1,8,7,2,4]
p bubble_sort(arr)
