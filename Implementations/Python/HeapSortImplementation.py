def heapify(arr, HeapSize, currentNodeIndex):
    '''
    Max heap construction algorithm. Heap construction begins from the currentNodeIndex.
    Total Number of Comparisons required = 2 * log(n); n is the number of levels in the tree.
                                            (comparing both the left/right subtree so 2 logn)
    Total Number of Swaps required = log(n); In worst case, currentNodeIndex is the minimum among all.
    Finally total time taken for Heapify = #swaps + #comparisons
                                         = O(logn) + O(2 * logn)
                                         = O(logn)

    '''
    
    LeftIndex = 2 * currentNodeIndex + 1
    RightIndex = 2 * currentNodeIndex + 2
    largest = currentNodeIndex

    if LeftIndex < HeapSize and arr[LeftIndex] > arr[currentNodeIndex]:
        largest = LeftIndex
    if RightIndex < HeapSize and arr[RightIndex] > arr[largest]:
        largest = RightIndex
    if largest != currentNodeIndex:
        arr[currentNodeIndex], arr[largest] = arr[largest], arr[currentNodeIndex]
        heapify(arr, HeapSize, largest)
    


def heapSort(arr):

    '''
    TimeComplexity = Time(creating the Minheap/Maxheap) +  Time(total) === O(n * logn)
    Explanation:
        Time(creating the Minheap/Maxheap) = O(N)
        Time(total) = O(n*logn) 

            delete 1st time & heapify from root = O(logn)
            delete 2nd time & heapify from root = O(logn)
            delete 3rd time & heapify from root = O(logn) Same process is repeated until the last element.
            delete nth element of the tree = O(logn)
   
    '''
    length = len(arr)
    PresentIndex = length //2 -1
    
    # Building MaxHeap starting from the last internal node to down the line to root node.
    # Time complexity for heapify the tree from the given subtree is O(logn)
    # We are iterating this heapify for n/2 times .
    # Hence, the total time required for building the Maxheap is n * log(n) --> BLUNDER
    
    # Actually the logic lies in the total number of nodes and the comparisons required at each level.
    # Total Time Complexity for building the Min/Max heap is O(N)

    while ( PresentIndex)>= 0:
        heapify(arr, length, PresentIndex)
        PresentIndex -=1

    for i in range(length-1, 0, -1):
        arr[i], arr[0] = arr[0], arr[i]
        heapify(arr, i, 0)




inputArray = [5,4,3,2,1,0]
heapSort(inputArray)
print(inputArray)
