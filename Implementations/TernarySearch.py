
# T(N) = T(N/3)+ C
#Function Implementation
def ternarySearch(arr, start, end, key):
    
    mid1 = start + (end-start)//3
    mid2 = end- (end-start)//3
    
    while start<=end:
        if arr[mid1] == key: return mid1
        if arr[mid2] == key: return mid2
        elif arr[mid1] > key:
            return ternarySearch(arr, start, mid1-1, key)
        elif arr[mid2]< key:
            return ternarySearch(arr, mid2+1, end, key)
        else:
            return ternarySearch(arr, mid1+1, mid2-1, key)
        
    return -1


# Driver Code

arr=[20,25,47,56,59,63,65,79,82]
ternarySearch(arr,0, len(arr)-1, 82)

# Recurrence Relation for Ternary Search: T(n) = T(n/3) + c 

$T(n) = O(log_{3}n) $
