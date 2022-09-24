'''
nums is sorted in non-decreasing order.

Input: nums = [-4,-3,0,-2,-1]
Output: [0,1,4,9,16]
Explanation: After squaring, the array becomes [16,9,0,4,1].
After sorting, it becomes [0,1,4,9,16].

'''

def sortinput(nums):

    l=[0]* len(nums)

    left = 0
    right = len(nums) -1
    k = len(nums)-1

    while left <= right:

        if (abs(nums[right]) >= abs(nums[left])):
            l.pop(k)
            l.insert(k, nums[right] * nums[right])
            k = k - 1
            right -=1
        else:
            l.pop(k)
            l.insert(k,nums[left] * nums[left])
            k = k -1
            left +=1
    return l

print(sortinput([-4,-1,0,3,10]))
