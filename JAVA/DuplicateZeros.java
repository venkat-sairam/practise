package Patterns;
import java.util.ArrayList;
import java.util.List;

public class DuplicateZeros {
    public static void main(String[] args) {


        List<Integer> list = new ArrayList<>();

        int[] arr = new int[]{1, 0, 2, 0,2};
        for (int j : arr) {
            if (j == 0) {
                list.add(0);

            }
            list.add(j);
        }
        for (int i = 0; i < arr.length; i++)
            arr[i] = list.get(i);
        for (int i: arr
             ) {
            System.out.println(i);

        }
    }

}
