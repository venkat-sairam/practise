package PriorityQueue;
import java.util.ArrayList;
import java.util.PriorityQueue;

public class SortNearlySortedArray {
    public static void main(String[] args) {
        int[] arr = new int[]{2, 3, 1, 4, 6, 7, 5, 8, 9};
        int k = 2;

        /*
        Given input is almost sorted form. We can use the concept of Heap Data Structure which is best and efficient as:
        1.      This is similar to sliding window technique in which all the K elements are added into the Heap which takes O( K * logn) time.
                    a.) For inserting one element into the heap, the time required is equal to the number of levels in Heap ~ O(logn)
                                 Here we are  inserting the elements into the heap K times --> o(K * logn) time.
                    b) After step- a, heap contains the K elements --> If we perform peek(), we will get the minimum element in O(1) time.
                    c). We will repeat the same steps from K+1 to InputSize --> At most O(K * logn) time
                                . Remove the element from the queue --> O(1) time
                                . Insert into the Heap --> O(logn) time

        Overall time required = O( K *logn) time is required for sorting the nearly sorted array.
        Overall space = O(1) Since we are not using any extra space.

         */
        ArrayList<Integer> list = new ArrayList<>();

        for (int item : arr) {
            list.add(item);
        }
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int i = 0; i <= k; i++) {

            pq.add(list.get(i));
        }
        for (int i = k+1; i < list.size(); i++ )
        {
            System.out.println(pq.remove());
            pq.add(list.get(i));
        }
        while(pq.size()>0)
        {
            System.out.println(pq.remove());
        }
        //System.out.println(result);
    }
}
