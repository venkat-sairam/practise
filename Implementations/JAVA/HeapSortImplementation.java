import java.util.Scanner;

public class HeapSortImplementation {

    public static void main(String[] args) {

        int[] arr = new int[]{1,2,0,3,4,5, 123, -90};


        int PresentIndex = arr.length /2 -1;
        while (PresentIndex >=0)
        {
            heapify(arr, arr.length, PresentIndex);
            PresentIndex = PresentIndex -1;
        }

        for (int i = arr.length -1; i>=0; i--)
        {
            int temp = arr[i];
            arr[i] = arr[0];
            arr[0] = temp;
            heapify(arr, i, 0);
        }

        for(int i = 0; i < arr.length; i++)
        {
            System.out.print(arr[i] + " ");
        }
    }


    public static void heapify(int[] arr, int N, int CurrentNodeIndex)
    {
        int largest = CurrentNodeIndex;

        int leftIndex = 2 * CurrentNodeIndex + 1;
        int rightIndex = 2 * CurrentNodeIndex + 2;

        if ((leftIndex < N) && (arr[leftIndex] > arr[CurrentNodeIndex])) largest = leftIndex;
        if ((rightIndex < N) && (arr[rightIndex] > arr[largest])) largest = rightIndex;

        if (largest != CurrentNodeIndex)
        {
            int temp = arr[CurrentNodeIndex];
            arr[CurrentNodeIndex ] = arr[largest];
            arr[largest] = temp;

            heapify(arr, N, largest);
        }

    }
}
