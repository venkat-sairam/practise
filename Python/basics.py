

class car:
    """
    class to initialize the car and its properties
    
    """
    def __init__(self, name, model, mileage, year) -> None:
        
        self.name = name
        self.model = model
        self.mileage=mileage
        self.year=year

    
class test:
    
    # object reference need not be self.
    # We can use custom naming instead of self keyword.
     
    def __init__(a, m, y, c) -> None:
        a.color = c
        a.model_name=m
        a.year=y
    
    
    # Similar to override in JAVA where the in-built str class is over-ridden to 
    # provide the custom message to the user instead of object reference in Hexa-decimal value.
    
    def __str__(self) -> str:
        return "this is a sample class which accepts model/year of purchase/color type to the user."       
            
    def setColor(self, colorType):
        self.color = colorType
        
        
    def getColor(self):
        return self.color
    
    def getYearOfPurchase(self):
        return self.year
                
    def getModel(self):        
        return self.model_name
        
t = test('swift',2022,'blue')
print(t.model_name)
print(t.getModel())

# Print the test class object reference when the __Str__() method is over-ridden.
print(t)    
    
    
    


class Student:
    
    def __init__(self,name, age, id, email, topicName) -> None:
        
        self.name = name
        self.age = age
        self.id = id
        self.email = email
        self.topicName = topicName
        
    def getCurrentTopic(self):
        
        return self.topicName
    
    def getId(self):
        
        if type(self.id) =='str':
            return ""
        return str(self.id)
    
    def __str__(self) -> str:
        return "A sample Student class which accepts name/age/email-id/idnumber/topicname"
    

std = Student('Venkat', 26, 54, "venkata.yanamandra@yahoo.com", 'OOPS')
print(std)

    