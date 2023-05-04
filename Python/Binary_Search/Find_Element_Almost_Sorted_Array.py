class FindElementInAlmostSortedArray:
    
    def modifiedBinarySearch(self, nums, key):
        
        low = 0
        high = len(nums) -1
        
        while low <= high:
            mid = low + (high - low) //2
            
            if nums[mid] == key:
                return mid
            elif  mid-1 >= low and nums[mid-1] == key:
                return mid -1
            elif mid + 1 <= high and nums[mid+1] == key:
                return mid +1
            elif nums[mid] > key:
                high = mid - 2
            else:
                low = mid + 2
        return -1
    def findElement(self, nums, key):
        index = self.modifiedBinarySearch(nums, key)
        if index != -1:
            return f"{key} exists at the index: {index} in the given array: {nums}"
        else:
            return f"{key} doesn't exists in the array: {nums}"
        
print(FindElementInAlmostSortedArray().findElement([1, 2, 4,3, 5], 15))
print(FindElementInAlmostSortedArray().findElement([1, 2, 4,3, 5], 4))
