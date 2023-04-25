class FindFirstAndLastPositionOfElement:
    
    def __init__(self):
        self.first , self.last = -1, -1
    
    def findElement(self, nums,key,isFirst):
        
        ans = -1
        low = 0
        high = len(nums) -1
        
        while low <= high:            
            
            mid = low + (high-low)//2            
            if nums[mid] < key:
                low = mid+1
            elif nums[mid] > key:
                high = mid-1
            else:
                if isFirst:
                    high = mid-1
                else:
                    low = mid+1
                ans = mid
        
        return ans
    
    def findBothElements(self, nums, key):
        self.first = self.findElement(nums, key, True)
        self.last= self.findElement(nums, key, False)
        return self.first, self.last

nums = [1,2,3,3,3,4,5]
key = 3
FindFirstAndLastPositionOfElement().findBothElements(nums,key)
            
