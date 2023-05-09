class FindMinimumDifferenceElementSortedArray:
    
    """
    There are two possible cases to search for the given element
    case:1
        If the key element is found in the given sorted array, then 
            arr[mid] holds the minimum difference and hence key is the minumum difference element.
    Case:2
        If the key element is not found in the given sorted array, then
            key always lies in between two values where the difference among one of those values is Minimum.
    
    """
    
    
    def __init__(self):
        
        self.ans = -1
    
    def modifiedBS(self, nums, key):
        
        low = 0
        high = len(nums)-1
        
        if key > nums[high] or key < nums[low]:
            return f"Given element: [{key}] doesn't lie in the lower/upper bounds of the sorted array"
        
        while low <= high:
            mid = low + (high - low) // 2

            if nums[mid] == key:
                return nums[mid]
            elif nums[mid] > key:
                high = mid -1
            else:
                low = mid + 1
        return max(abs(nums[high] - key), abs(nums[low]-key))
print(FindMinimumDifferenceElementSortedArray().modifiedBS([1,2,3,4,5,7,8,9,10], 6))
print(FindMinimumDifferenceElementSortedArray().modifiedBS([1,2,3,4,5,7,8,9,10], 60))
