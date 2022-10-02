package PriorityQueue;
import java.util.*;

public class ThreePairSumClosestToTarget {

    public static void main(String[] args) {
        int[] arr = new int[]{-1,2,1,-4};
        int left = 0;
        int right = arr.length - 1;
        int target = 1;
        int currentSum=0;
        Arrays.sort(arr);
        for (int i = 0; i <= arr.length-3; i++)
        {
            if (i > 0 && arr[i] ==arr[i-1])
            {
                left++;
                continue;
            }
            currentSum = arr[i];
            int TwoSumOutput =findTwoSum(arr, i+1, right, target-currentSum);
            if (TwoSumOutput !=-1)
            {
                System.out.println(currentSum+ TwoSumOutput);
            }

        }
    }

    public static int findTwoSum(int[] input, int start, int end, int target)
    {

            int left =start;
            int right = end;

            while(left < right)
            {
                if (left != start && input[left] == input[left-1])
                {
                    left++;
                    continue;

                }
                int presentSum = input[left] + input[right];
                if (presentSum== target)
                {
                    return presentSum;
                }
                else if (presentSum > target)
                {
                    right--;
                }
                else
                {
                    left++;
                }
            }
            return -1;
    }
}
