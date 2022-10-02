package PriorityQueue;
import java.util.*;

public class MostFeaturedProduct {
    public static void main(String[] args) {
        String[] arr = new String[]{"yellowShirt", "redHat", "blackShirt", "bluePants", "redHat","pinkHat", "blackShirt", "yellowShirt", "greenPants", "greenPants", ""};
        List<String> str = Arrays.asList(arr);
        ArrayList<String> result = new ArrayList<>();
        for (String s: str)
        {
            System.out.println(s);
        }

        HashMap<String, Integer> hm = new HashMap<>();

        //  Finding the frequency of each element in the given list.
        for (int i = 0; i < str.size();i++)
        {
            String current = str.get(i);

            if(hm.containsKey(current))
            {
                hm.put(current, hm.get(current) + 1);
            }else
            {
                hm.put(current, 1);
            }
        }

        // Finding the MAX Frequency among the given elements
        int maxfreq=0;
        for (String key : hm.keySet())
        {
            int currentFreq = hm.get(key);
            maxfreq= Math.max(currentFreq, maxfreq);

        }
        // Finding the Element(s) which has maximum frequency.
        for (String key : hm.keySet())
        {
            if(hm.get(key)==maxfreq) {
                result.add(key);
            }
        }

       // Sorting the elements in alphabetically Ascending  Order of the result-set as there may be more than one key which has MAX Frequency.
        Collections.sort(result);
        System.out.println("-------------------------------------");
        System.out.println(result);
    }
}
