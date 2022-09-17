public class FindFirstIndex {

    public static void   main(String[] args) {

        int[] arr = new int[]{0,0,0,0,0,0,0,1,1,1,1};

        // Function Call
        System.out.println("First Index of the Failed Product is: "+findFailedProductLocation(arr));
    }

    // Function Implementation
    public static int  findFailedProductLocation(int[] arr) {
         /*

            Time Complexity: O(nlogn) since we are using Binary search approach to find the square root of N
            Space Complexity: O(1)

        */
        int key = 1;
        int low = 0, high = arr.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (arr[mid] == key) {
                if ((mid == low) || (arr[mid - 1] != arr[mid])  ) {
                    return mid;
                } else {
                    high = mid - 1;
                }
            } else if (arr[mid] > key) {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return -1;
    }
}


