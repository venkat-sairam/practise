class ReadFromFile:
    
    def __init__(self, filename, type, date, size) -> None:
        
        self.filename = filename
        self.type = type
        self.date = date
        self.size = size
        
    
    def fileOpen(self):
        try:
            fileRef = open(self.filename, "w")
            fileRef.write("writing first line of code in this file. ")
            print(fileRef.name) # Prints the file name in the output console.
            fileRef.close()
            
        except FileNotFoundError as e:
            print(e)          
            
    def fileRead(self)  :
        
        try:
            fileRef = open(self.filename, "r")
            print(fileRef.readlines())
            fileRef.close()
            
        except FileNotFoundError as e:
            print(e)
        
    def appendToFile(self):
        
        try:
            fileRef = open(self.filename, "a")
            fileRef.write("appending to the existing file {} and {}".format(self.filename, self.type))
            fileRef.close()
        except FileNotFoundError as e:
            print(e)
    
    
r = ReadFromFile("new.txt", 'text file', '27-sept-2022', '1KB')       
r.fileOpen()
r.fileRead()
r.appendToFile()


 