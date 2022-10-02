package PriorityQueue;
import java.util.*;

import static java.util.List.*;

public class BasicsOfPQ {

    public static void main(String[] args) {
        int[] arr = new int[]{12,45,65,32,47,85,0,-65,54};

      ArrayList<Integer> list = new ArrayList<>();
      for (int item: arr)
      {
          list.add(item);
      }


      // Creating a priority queue with the given list of elements in min-max order.
        PriorityQueue<Integer> pq = new PriorityQueue<>(list);

      /*
        Size: returns the size of the priority Queue
        Peek: Returns the min  element in the Queue.
      Remove: Removes the min element in the Queue. and NoSuchElementException, if element not exists in the queue.
      After removing all the elements in the Queue--> Output is in sorted order(min-max)
       */
        System.out.println("Heap output in Non-decreasing order: ");
      while(pq.size() >0)
      {
          System.out.println(pq.peek());
          pq.remove();
      }
        System.out.println(pq);


        /*
        Collections.reverseOrder() -->  Maintain the MAX Heap.
        Size: returns the size of the priority Queue
        Peek: Returns the min  element in the Queue.
        Poll: Returns and removes the element pointed by the first pointer.
      Remove: Removes the min element in the Queue. and NoSuchElementException, if element not exists in the queue.
      After removing all the elements in the Queue--> Output is in sorted order(min-max)
       */
      pq  = new PriorityQueue<>(Collections.reverseOrder());

        for (int item: arr)
        {
            pq.add(item);
        }

        System.out.println("Heap output in Non- increasing order: ");
        while(pq.size() >0)
        {
            System.out.println(pq.poll());

        }



    }

}
