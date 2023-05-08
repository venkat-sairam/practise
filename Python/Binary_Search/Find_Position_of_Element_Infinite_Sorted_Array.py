class FindPositionOfElementInfiniteSortedArray:
    
    def __init__(self):
        self.res = -1         
        self.low = 0
        self.high = 1
        
    def findElement(self, nums, key):
        if not key  in nums:
            return -1
        while (nums[self.high] < key) and (self.high <= len(nums) -1):
            self.low = self.high
            self.high *= 2
            
    def modifiedBS(self, nums, key):
        
        self.findElement(nums, key)
        
        low = self.low
        high  = self.high
        
        while low <= high:
            mid = low + (high - low) //2
            
            if nums[mid] == key:
                return mid
            elif nums[mid] < key:
                low = mid + 1
            else:
                high = mid -1
        return -1
        

nums =  list((i//2) for i in range(1, 10000))
nums = list(set(nums))


FindPositionOfElementInfiniteSortedArray().modifiedBS(nums, 10)
