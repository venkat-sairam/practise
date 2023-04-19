class GeneratePermutaionsOfString:

    """
    Returns the possible permutations of a given input string
    Total number of permutatins of a given string are n!
    """

    def __init__(self) -> None:
        self.result = []

    def swap(self, string: str, ind1: int, ind2: int):
        string = list(string)
        string[ind1], string[ind2] = string[ind2], string[ind1]
        return "".join(string)

    def generatePermutations(self, string: str, currInd: int):

        if currInd == len(string):
            self.result.append(string)
            return
        for i in range(currInd, len(string)):
            string = self.swap(string=string, ind1=i, ind2=currInd)
            self.generatePermutations(string=string, currInd=currInd+1)
            string = self.swap(string=string, ind1=i, ind2=currInd)

        return sorted(self.result)


inputStr = "abc"
currentIndex = 0
objRef = GeneratePermutaionsOfString()
print(objRef.generatePermutations(string=inputStr, currInd=currentIndex))
