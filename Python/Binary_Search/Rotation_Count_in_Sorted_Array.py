def findArraySortedCount(nums):
    """
    1.To Find the number of times array is sorted, identify the index of the minimum element in the array.
    2. min ele property is as follows:
        previous element is greater than the min element
        min element is smaller than the next element.
        assign mid = low + (high-low)//2
        
        assign prev = (mid -1 + N) % N
        assign next = ( mid + 1 ) % N
        
        Repeat until low <= high:
        
        case-1:
            check if the array is already in the sorted format and whether any rotation is done or not?
            this can be achieved by comparing the arr[0] with arr[n-1] elements.
            if arr[0] < arr[n-1] then array is sorted and no rotations were performed. 
            Hence, return the rotation count as Zero.
        case-2: 
            arr[mid] <= arr[prev] and arr[mid] <= arr[next]
            Here, the min element index denotes the number of times sorted array is rotated.
            Return the rotation count as Mid index.
        case- 3:
            if case-2 fails, then 
            check for the left and right side subarrays from the mid element.
            if arr[low] < arr[mid -1] then the left side subarray is already sorted. So the mid index won't exists in this search space.
                assign low = mid +1
            if arr[mid] < arr[n-1] then 
            assign high = mid -1
    """
    
    
    low = 0
    high = len(nums)-1
    N= high
    while low <= high:
        
        mid = low + (high- low) // 2
        
        prev = (mid-1 + N) % N 
        next = (mid + 1) % N
        
        if nums[low] <= nums[high]:
            return 0
        elif nums[mid] < nums[prev] and nums[mid] <nums[next]:
            return mid
        elif nums[mid] < nums[high]:
            high = mid -1
        elif nums[low] <= nums[mid]:
            low = mid +1
findArraySortedCount([15, 18, 2, 3, 6, 12])
