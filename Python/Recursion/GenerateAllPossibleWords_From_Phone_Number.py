class GeneratePossibleWordsFromPhoneNumbers:
    
    def __init__(self):
        self.result = []
        self.mp = {
            0: [],
            1: [],
            2: ['a','b','c'],
            3: ['d', 'e', 'f'],
            4: ['g', 'h', 'i'],
            5: ['j', 'k', 'l'],
            6: ['m', 'n', 'o'],
            7: ['p', 'q', 'r', 's'],
            8: ['t', 'u', 'v'],
            9: ['w', 'x', 'y', 'z']
        }
        
    def generateWords(self,  currString: str, currInd: int, inputArray: list):
        
        if currInd == len(inputArray):
            self.result.append(currString)
#             print(currString)
            return
        
        number = inputArray[currInd]
        for character in self.mp[number]:
            self.generateWords(currString + character, currInd+1, inputArray)
            
            
    def displayAllPossibleWords(self):
        return self.result
objRef = GeneratePossibleWordsFromPhoneNumbers()
input = [2,3]
ind = 0
currStr = ""

objRef.generateWords(currStr, ind, input)

print(objRef.result)
