class FindNextAlphabetSortedArray:
    
    def __init__(self):
        self.result = -1
    
    
    def findNextChar(self, nums, key):
        
        low = 0
        high = len(nums) - 1
       
        while low <= high:
            
            mid = low + (high - low) // 2
            
            if nums[mid] == key:
               # When the given element is found, then continue searching in the second-half of the array.
                # Because, element is a character and we want the next character not the ceil of ele as numbers.
                low = mid + 1
            elif nums[mid] < key:
                low = mid + 1
            else:
                self.result = nums[mid]
                high = mid - 1
                
       
        return self.result
    
print(FindNextAlphabetSortedArray().findNextChar(['a', 'b', 'c', 'f', 'j'], 'e'))
print(FindNextAlphabetSortedArray().findNextChar(['a', 'b', 'c', 'f', 'j'], 'c'))  
