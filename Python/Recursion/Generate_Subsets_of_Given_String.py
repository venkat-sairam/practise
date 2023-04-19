class GenerateSubsetsOfString:

    def __init__(self) -> None:
        self.ans = []

    def generateSubsets(self, string: str, currStr: str, currentInd: int):

        if currentInd == len(string):
            self.ans.append(currStr)
            return
        # include the character positioned at the current Index
        self.generateSubsets(string=string, currStr=currStr +
                             string[currentInd], currentInd=currentInd + 1)

        # Exclude the character positioned at the current Index.
        self.generateSubsets(string=string, currStr=currStr,
                             currentInd=currentInd+1)

        return sorted(self.ans)


string = "abc"
currentString = ""
currentIndex = 0
objRef = GenerateSubsetsOfString()
print(objRef.generateSubsets(string=string,
      currStr=currentString, currentInd=currentIndex))
