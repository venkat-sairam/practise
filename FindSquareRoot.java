import java.util.Scanner;

public class FindSquareRoot {

    public static void   main(String[] args) {
        
        // Driver Code
        long n;
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a Value to find the square root: ");
        n = sc.nextLong();
        
        // Function Call
        System.out.println("Square root of " + n + " is" + " " + calculateSquareRoot(n));
    }

    // Function Implementation
    public static long  calculateSquareRoot(long key)
    {        
         /*
            Program: To Find the square root of the given Number
            Input: int/long value
            Output: Returns the Square root of the given number
            Time Complexity: O(logn) since we are using Binary search approach to find the square root of N
            Space Complexity: O(1)    

        */
        
        if (key == 1) return 1;

        long  low = 1, high = key /2;
        long  ans=-1;



        while (low <= high)
        {
            long  mid = low + (high - low)/2;
            long sqr = mid * mid;

            if (sqr < key)
            {
                ans = mid;
                low = mid + 1;
            }
            else if ( sqr > key)
            {
                high = mid -1;
            }
            else
            {
                return mid;
            }
        }
        return ans;
    }
}


