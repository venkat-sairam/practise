class FindCeilOfElementSortedArray:
    
    def __init__(self):
        self.result = -1
    
    def findCeilOfElement(self, nums, key):
        
        low = 0
        high = len(nums) - 1
        
        while low <= high:
            
            mid = low + (high - low)//2
            if nums[mid] == key:
                return nums[mid]
            elif nums[mid] < key:
                low = mid + 1
            else:
                self.result = nums[mid]
                high = mid -1
                
        return self.result
print(FindCeilOfElementSortedArray().findCeilOfElement([1,2,3,4,5,6,7,8,9], 7.25))
print(FindCeilOfElementSortedArray().findCeilOfElement([1,2,3,4,5,6,7,8,9], 9))
