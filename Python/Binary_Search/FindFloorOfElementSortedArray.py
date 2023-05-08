class FindFloorOfElementSortedArray:
    
    def __init__(self):
        self.result = -1
    
    def findFloorUsingBS(self, nums, key):
        
        low = 0
        high = len(nums) -1
        
        while low <= high:
            mid = low + (high - low) // 2
            
            if nums[mid] == key: # if the middle element is the floor value of the Key 
                
                return numd[mid] # then return middle element in the array.
            elif nums[mid] > key:
                high = mid - 1
            else:
                self.result = nums[mid]
                low = mid + 1
        return self.result
    
FindFloorOfElementSortedArray().findFloorUsingBS([1,2,3,4,5,6,7,8,9,10], 5.2)
