package PriorityQueue;
import java.util.Arrays;
import java.util.List;
import java.util.PriorityQueue;
import java.util.stream.Collectors;

public class Find_K_Largest_Elements {

    public static void main(String[] args) {
        int[] arr = new int[]{12,45,65,32,47,85,0,-65,54};
        List<Integer> list = Arrays.stream(arr).boxed().toList();
        int k = 3;

        PriorityQueue<Integer> pq = new PriorityQueue<>();

        for (int i=0; i < list.size(); i++)
        {
            if (i < k)
            {
                pq.add(list.get(i));
            }
            else
            {
                if (list.get(i) > pq.peek())
                {
                    pq.remove();
                    pq.add(list.get(i));
                }
            }
        }
        while (pq.size() > 0)
        {
            System.out.println(pq.poll());
        }


    }
}
