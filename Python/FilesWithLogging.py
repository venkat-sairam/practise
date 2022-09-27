import logging as lg

lg.basicConfig(filename='output.log', level=lg.ERROR)

class ReadFromFile:
    
    def __init__(self, filename, type, size, data) -> None:
        
        self.filename = filename
        self.type = type
        self.size = size
        self.data = data
    
    def logging(self, errorMessage):
        lg.error(errorMessage)
        
    def openFile(self):        
        try:
            with open(self.filename, "a") as file:
                file.writee("Writing the content to the file inside the second program which implements basic logging ")            
        except Exception as e:            
            self.logging(e)
            
    def readFile(self):
        
        try:
            with open(self.filename, "r") as file:
                printf(file.read())            
        except Exception as e:
            self.logging(e)
            

    def writeFile(self):        
        try:
            with open(self.filenamee, "w+") as file:
                file.write("Writing into the file named: {} inside the class: {}".format(self.filename, self.__class__.__name__,))
        except Exception as e:
            self.logging(e)
        
ref = ReadFromFile("new.txt", 'text file', '27-sept-2022', '1KB')
ref.openFile()
ref.readFile()
ref.writeFile()




    
