function insertionSort(arr) {
  if (arr.length <= 1) return arr;

  let result = [arr[0]];
  for (let i = 0; i < arr.length; i++) {
    for (let j = result.length-1; j >= 0; j--) {
      if (arr[i] > result[j]) {
        console.log(result);
        let left = result.splice(0,j+1);
        left.push(arr[i]);
        result = left.concat(result);
        break;
      }
    }
  }
  return result;
}

const arr = [6,5,3,1,8,7,2,4];
console.log(insertionSort(arr));
