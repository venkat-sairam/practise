class FindTheCountOfElementInSortedArray:
    
    def __init__(self) -> None:
        self.first = -1
        self.last = -1
    
    def findPositionOfKeyElement(self, nums: list, key: int, isFirst: bool):
        
        low = 0
        high = len(nums) - 1
        ans = -1
        while low <= high:
            mid = low + (high-low)// 2
            
            if nums[mid] < key:
                low =  mid + 1
            elif nums[mid] > key:
                high = mid - 1
            else:
                if isFirst:
                    high = mid - 1
                else:
                    low = mid + 1
                ans = mid
        return ans

    def findTheCountOfKeyElement(self, nums, key):
        self.first = self.findPositionOfKeyElement(nums, key, True)
        self.last = self.findPositionOfKeyElement(nums, key, False)
        if self.first == -1 or self.last == -1:
            return f"{key} doesn't exists in the array: {nums}"
        return self.last - self.first + 1
    
nums = [1,2,3,3,3,3,3,4,5]
key = 3

print(f"count = {FindTheCountOfElementInSortedArray().findTheCountOfKeyElement(nums, key)}")
         