class FindElementInRotatedSortedArray:
    
    def __init__(self):
        pass
    
    def findMinElementIndex(self, nums):
        low = 0
        high = len(nums) - 1
        N= high
        while low <= high:
            
            mid = low + (high - low) // 2
            prev = (mid - 1 + N) % N
            next = (mid + 1) % N
            
            if nums[low] < nums[high]: return 0
            
            elif nums[mid] < nums[prev] and nums[mid] < nums[next]:
                return mid
            elif nums[low] < nums[mid]:
                low = mid + 1
            elif nums[mid] < nums[high]:
                high = mid -1
        return -1
    
    def binarySearch(self,nums, low, high, key):
        
        while low <= high:
            mid = low + (high - low) //2
            if nums[mid] == key:
                return mid
            elif nums[mid] < key:
                low = mid + 1
            else:
                high = mid - 1
        return -1 # if key doesn't exists in the given input array.
    def findGivenElement(self, nums, key):
        minIndex = self.findMinElementIndex(nums)
        left = self.binarySearch( nums, 0, minIndex -1 , key)
        right = self.binarySearch(nums, minIndex, len(nums) -1, key)
        
        if left == -1 and right == -1:
            return f"{key} doesn't exists in the given array: {nums}"
        else:
            if left != -1:
                return f" {key} exists at the index: {left+1} in the given array: {nums}"
            if right != -1:
                return f"{key} exists at the index: {right+1} in the given array: {nums}"
                
FindElementInRotatedSortedArray().findGivenElement([15, 18, 2, 3, 6, 12], 12)
