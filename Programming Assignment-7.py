"""
1. Write a Python Program to find sum of array
"""


list_items = []
print("Enter elements one after other and hit enter two times to stop input")
print()

while True:
        
    arr = input("Enter array elements to find the sum:  ")
    if arr:
        list_items.append(int(arr))

    else:
        break

print("Sum of all the elements in the given array is: ",sum(list_items))


"""2. Write a Python Program to find largest element in an array"""

'''Using the array of the program 1 as input'''

maximum = list_items[0]

for i in range(1, len(list_items)):
    if list_items[i] > maximum:
        maximum = list_items[i]

print("Maximum element of the array is: ",maximum)


"""
3. Write a Python Program for array rotation
"""

print(list_items)
i = len(list_items) - 1
temp = list_items[i]
while i>0:
    list_items[i] = list_items[i-1]
    i = i - 1

list_items[0] = temp

print("Rotated array: ", list_items)
   
""" 
4. Write a Python Program to Split the array and add the first part to the end
"""

# Using the previous problem list_items array as input
count_value = 0
for i in range(0, len(list_items)//2):
    count_value = count_value + list_items[i]

print("Sum of first part elements in the array is: ",count_value)

"""
5. Write a Python Program to check if given array is Monotonic?
"""

x = False
for i in range(0, len(list_items)-1):
   
    if  ((list_items[i]+1 == list_items[i+1]) or(list_items[i] -1 == list_items[i+1])) == False:
        x = True
        break

if x == True:
    print("Given list is not monotonic")

else:
    print("Given array is monotonic")