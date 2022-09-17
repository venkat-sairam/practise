import java.util.Scanner;

public class CheckIsPerfectSquare {

    public static void   main(String[] args) {

        // Driver Code
        long n;
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a Value to check perfect square or not: ");
        n = sc.nextLong();

        // Function Call

        if(checkIFPerfectSquare(n))
            System.out.println( n + " is" + " a Perfect Square");
        else
            System.out.println( n + " is" + " not a Perfect Square");

    }

    // Function Implementation
    //Time Complexity: O(logn) since we are using the modified version of Binary Search.
    public static boolean  checkIFPerfectSquare(long key)
    {
       if (key == 1) return true;

        long  low = 1, high = key /2;

        while (low <= high)
        {
            long  mid = low + (high - low)/2;
            long sqr = mid * mid;

            if (sqr < key)
            {

                low = mid + 1;
            }
            else if ( sqr > key)
            {
                high = mid -1;
            }
            else
            {
                return true;
            }
        }
        return false;
    }
}

