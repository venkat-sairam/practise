package PriorityQueue;
import java.util.ArrayList;
import java.util.Collections;
import java.util.PriorityQueue;

public class MedianPriorityQueue {
    public static void main(String[] args) {
        int[] arr = new int[]{12,45,65,32,47,85,0,-65,54};

        ArrayList<Integer> list = new ArrayList<>();
        for (int item: arr)
        {
            list.add(item);
        }
        PriorityQueue<Integer> left = new PriorityQueue<>((Collections.reverseOrder()));
        PriorityQueue<Integer> right = new PriorityQueue<>();

        for (int i = 0; i < list.size(); i++)
        {
            if (left.size() - right.size() <=1)
            {
                left.add(list.get(i));
            }
            else
            {
                right.add(left.poll());
            }
        }

        while(left.size() > 0)
        {
            System.out.println(left.poll());
        }



    }
}
