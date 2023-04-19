class GenerateSubsetsOfArray:

    def __init__(self) -> None:
        self.ans = []

    def generateSubsets(self, nums: list, currArray: list, currIndex: int):
        if currIndex == len(nums):
            self.ans.append(currArray.copy())
            return
        # includes the current Element in the result.
        currArray.append(nums[currIndex])
        self.generateSubsets(nums, currArray=currArray,
                             currIndex=currIndex + 1)

        # Exclude the current element.
        currArray.pop()
        self.generateSubsets(nums, currArray=currArray, currIndex=currIndex+1)

        return sorted(self.ans)


nums = [1, 2, 3]
currArray = []
currIndex = 0
objRef = GenerateSubsetsOfArray()
print(objRef.generateSubsets(nums, currArray, currIndex))
