class GenerateSubsetSums:
    
    def __init__(self):
        self.res = []
        
    def subsetSums(self, currSum:int , currIndex: int, numsArray: list):
        
        if currIndex == len(numsArray):
            self.res.append(currSum)
            return
        # Include the current Index to the subset sum.
        self.subsetSums(currSum + numsArray[currIndex], currIndex + 1, numsArray)
        
        # Exclude the curr Index
        self.subsetSums(currSum, currIndex+1, numsArray)
        
        
        
    def displaySbsetSums(self):
        return sorted(self.res)
        
_currInd = 0
_currSum = 0
_numsArray = [1,2,3]

objRef = GenerateSubsetSums()
objRef.subsetSums(_currSum, _currInd, _numsArray)
objRef.displaySbsetSums()
