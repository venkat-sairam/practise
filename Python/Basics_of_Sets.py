### Basic rules on sets in Python
# Set takes only one argument
# Set:  unordered/mutable/no-duplicates
##### Normal set declaration
my_set = {} # not an empty set declaration
print(type(my_set))  # type is Dictionary but not set

## Empty set declaration

my_set = set()
print(my_set)
print("Empty set type", type(my_set))

#Set with one element
my_set = {1}
print(my_set)
print("set with one element: ", type(my_set))


#set with more than one element
my_set = {1,2,3}
print(my_set)
print("type when more elements are added", type(my_set))

###### Set with Iterables as arguments

#set declaration with built in 'SET' method
# NOTE: 
#     Argument to the set method must be iterable.
#     Otherwise, TypeError will be returned to the user.
# myset = set(1) --> invalid since integers aren't iterable.

#set with  list as an argument
my_set = set([1,2,3,4,5])
print("list values as an argument to the set method: ",my_set)
print(type(my_set))

#set with string as an argument
# another way to display the unique characters in a given string.
my_set = set("welcome to python programming !!")
print(my_set) 

#### Add/Remove methods on sets
#Add method

myset = set()
myset.add(1)
myset.add(2)
myset.add(3)
myset.add("a")
myset.add("hello")
print(myset)
print(type(myset))

#Remove Method: 
#Returns a Key Error if the value is not a member of the given set.

myset.remove("hello")
print(myset)

# Discard Method
#Same as remove method. However, if the value is not a member of the set, no error is thrown 
myset.discard("hello")
print(myset)

# clear/pop
#### Set Operations: Union/ Intersecetion/Difference

odds={1,3,5,7,9}
evens={2,4,6,8,0}
primes={2,3,5,7}
setA = {1,2,3,4,5,6,7,8,9}
setB = {1,2,3,10,11,12}
#normal union/intersection/difference will not modify the original set. Instead, they will return a new one.

union_result = odds.union(evens)
print(union_result) 

intersection_result = odds.intersection(evens)
print(intersection_result) # empty set since there are no common elements in odds & evens set

even_primes = evens.intersection(primes)
print(even_primes)


difference_result = setA.difference(setB)
print("set difference with setA - setB", difference_result)

difference_res = setB.difference(setA)
print("set difference with setB - setA", difference_res)

# outputs values which are not in setA AND in setB

symm_difference = setB.symmetric_difference(setA)
print("symmetric difference result: ", symm_difference)
print(setA)
print(setB)
print(setA.union(setB))

setA.update(setB) # find union of setA and setB and update the result to setA
print(setA)

setA.intersection_update(setB) # updates setA with the setA.intersection(setB) result.
print(setA)

setA.difference_update(setB) # update setA with setA.difference(setB) result.
print(setA)

setA.symmetric_difference_update(setB) # update setA <-- setA.symmetric_difference(setB)
print(setA)

###### subset/superset/disjoint operations
setA = {1,2,3,4,5}
setB = {1,2,3}
setC = {7,8}
print(setA.issubset(setB))
print(setB.issubset(setA))

print(setA.issuperset(setB))
print(setB.issuperset(setA))

print(setA.isdisjoint(setC)) # disjoint sets: Intersection result is NULL.
